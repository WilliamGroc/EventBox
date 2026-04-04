package ws

import (
	"log"
	"net/http"
	"net/url"
	"strings"
	"sync"

	"github.com/gorilla/websocket"
)

// NewUpgrader construit un websocket.Upgrader dont CheckOrigin valide l'en-tête
// Origin contre la liste allowedOrigins fournie (valeurs brutes, ex.
// ["http://localhost:3000", "https://wedding.example.com"]).
//
// Si allowedOrigins est vide, le comportement de sécurité par défaut de
// gorilla/websocket est utilisé : il compare l'en-tête Origin au Host de la
// requête, ce qui est suffisant en développement local.
func NewUpgrader(allowedOrigins []string) websocket.Upgrader {
	if len(allowedOrigins) == 0 {
		// Comportement par défaut de gorilla : Origin == Host. Sûr en dev.
		return websocket.Upgrader{}
	}

	// Construire un set normalisé pour la comparaison O(1).
	allowed := make(map[string]struct{}, len(allowedOrigins))
	for _, o := range allowedOrigins {
		allowed[strings.ToLower(strings.TrimRight(o, "/"))] = struct{}{}
	}

	return websocket.Upgrader{
		CheckOrigin: func(r *http.Request) bool {
			origin := r.Header.Get("Origin")
			if origin == "" {
				// Pas d'en-tête Origin (client non-navigateur) : refuser par
				// défaut pour ne pas contourner la protection CSWSH.
				return false
			}
			// Normaliser : scheme + host (sans chemin ni trailing-slash).
			u, err := url.Parse(origin)
			if err != nil {
				return false
			}
			normalized := strings.ToLower(u.Scheme + "://" + u.Host)
			_, ok := allowed[normalized]
			if !ok {
				log.Printf("WebSocket: origine refusée: %q", origin)
			}
			return ok
		},
	}
}

// Client représente une connexion WebSocket active.
type Client struct {
	hub       *Hub
	conn      *websocket.Conn
	send      chan []byte
	closeOnce sync.Once
}

// Hub gère l'ensemble des clients WebSocket connectés.
type Hub struct {
	upgrader   websocket.Upgrader
	clients    map[*Client]bool
	Broadcast  chan []byte
	register   chan *Client
	unregister chan *Client
	mu         sync.RWMutex
	onMessage  func([]byte, *Hub)
}

// NewHub crée un Hub sans handler de messages entrants.
func NewHub(allowedOrigins []string) *Hub {
	return &Hub{
		upgrader:   NewUpgrader(allowedOrigins),
		clients:    make(map[*Client]bool),
		Broadcast:  make(chan []byte, 256),
		register:   make(chan *Client),
		unregister: make(chan *Client),
	}
}

// NewHubWithHandler crée un Hub avec un handler pour les messages entrants.
func NewHubWithHandler(allowedOrigins []string, onMessage func([]byte, *Hub)) *Hub {
	h := NewHub(allowedOrigins)
	h.onMessage = onMessage
	return h
}

// Run démarre la boucle principale du Hub (à lancer dans une goroutine).
func (h *Hub) Run() {
	for {
		select {
		case client := <-h.register:
			h.mu.Lock()
			h.clients[client] = true
			h.mu.Unlock()
		case client := <-h.unregister:
			h.mu.Lock()
			if _, ok := h.clients[client]; ok {
				delete(h.clients, client)
				close(client.send)
			}
			h.mu.Unlock()
		case message := <-h.Broadcast:
			h.mu.RLock()
			toDelete := []*Client{}
			for client := range h.clients {
				select {
				case client.send <- message:
				default:
					toDelete = append(toDelete, client)
				}
			}
			h.mu.RUnlock()
			if len(toDelete) > 0 {
				h.mu.Lock()
				for _, client := range toDelete {
					if _, ok := h.clients[client]; ok {
						delete(h.clients, client)
						close(client.send)
					}
				}
				h.mu.Unlock()
			}
		}
	}
}

// PublishLatest envoie msg sur le canal Broadcast de façon non-bloquante.
// Si le canal est plein, un message ancien est évincé pour laisser place
// au plus récent (pattern "dernier état"). En cas d'échec persistant, le
// message est droppé et loggué plutôt que de bloquer l'appelant.
func (h *Hub) PublishLatest(msg []byte) {
	select {
	case h.Broadcast <- msg:
		// envoyé directement
	default:
		// canal plein : tenter d'évincer un ancien message
		select {
		case <-h.Broadcast:
		default:
		}
		// second essai non-bloquant
		select {
		case h.Broadcast <- msg:
		default:
			log.Println("Hub: broadcast droppé (canal saturé)")
		}
	}
}

// ServeWS gère l'upgrade HTTP → WebSocket et enregistre le client.
func (h *Hub) ServeWS(w http.ResponseWriter, r *http.Request) {
	conn, err := h.upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("WebSocket upgrade error:", err)
		return
	}

	client := &Client{
		hub:  h,
		conn: conn,
		send: make(chan []byte, 256),
	}
	h.register <- client

	go client.writePump()
	go client.readPump(h)
}

func (c *Client) writePump() {
	defer func() {
		c.closeOnce.Do(func() {
			c.conn.Close()
		})
	}()
	for {
		message, ok := <-c.send
		if !ok {
			_ = c.conn.WriteMessage(websocket.CloseMessage, []byte{})
			return
		}
		w, err := c.conn.NextWriter(websocket.TextMessage)
		if err != nil {
			return
		}
		_, _ = w.Write(message)
		_ = w.Close()
	}
}

func (c *Client) readPump(h *Hub) {
	defer func() {
		h.unregister <- c
		c.closeOnce.Do(func() {
			c.conn.Close()
		})
	}()
	for {
		_, message, err := c.conn.ReadMessage()
		if err != nil {
			break
		}
		if h.onMessage != nil {
			h.onMessage(message, h)
		}
	}
}

// ServeWSWithInitial upgraade la connexion WebSocket, envoie un message initial
// au nouveau client avant de démarrer la boucle de lecture/écriture.
func (h *Hub) ServeWSWithInitial(w http.ResponseWriter, r *http.Request, initialMsg []byte) {
	conn, err := h.upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("WebSocket upgrade error:", err)
		return
	}

	client := &Client{
		hub:  h,
		conn: conn,
		send: make(chan []byte, 256),
	}

	// Envoyer le message initial dans le buffer avant d'enregistrer le client
	if initialMsg != nil {
		client.send <- initialMsg
	}

	h.register <- client

	go client.writePump()
	go client.readPump(h)
}

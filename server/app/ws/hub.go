package ws

import (
	"log"
	"net/http"
	"sync"

	"github.com/gorilla/websocket"
)

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
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
	clients    map[*Client]bool
	Broadcast  chan []byte
	register   chan *Client
	unregister chan *Client
	mu         sync.RWMutex
	onMessage  func([]byte, *Hub)
}

// NewHub crée un Hub sans handler de messages entrants.
func NewHub() *Hub {
	return &Hub{
		clients:    make(map[*Client]bool),
		Broadcast:  make(chan []byte, 256),
		register:   make(chan *Client),
		unregister: make(chan *Client),
	}
}

// NewHubWithHandler crée un Hub avec un handler pour les messages entrants.
func NewHubWithHandler(onMessage func([]byte, *Hub)) *Hub {
	h := NewHub()
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

// ServeWS gère l'upgrade HTTP → WebSocket et enregistre le client.
func (h *Hub) ServeWS(w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
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
	conn, err := upgrader.Upgrade(w, r, nil)
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

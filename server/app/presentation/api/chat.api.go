package api

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/WilliamGroc/EventBox/app/domain/usecases"
	"github.com/WilliamGroc/EventBox/app/ws"
	"github.com/go-chi/chi/v5"
)

type ChatAPI struct {
	getMessagesUseCase *usecases.GetMessagesUseCase
	sendMessageUseCase *usecases.SendMessageUseCase
	chatHub            *ws.Hub
}

type incomingChatMessage struct {
	Content string `json:"content"`
	Author  string `json:"author"`
}

func NewChatRoutes(
	router *chi.Mux,
	getMessagesUseCase *usecases.GetMessagesUseCase,
	sendMessageUseCase *usecases.SendMessageUseCase,
	chatHub *ws.Hub,
) *ChatAPI {
	api := &ChatAPI{
		getMessagesUseCase: getMessagesUseCase,
		sendMessageUseCase: sendMessageUseCase,
		chatHub:            chatHub,
	}

	router.Route("/chat", func(r chi.Router) {
		r.Get("/messages", api.GetMessages)
		r.Get("/ws", api.chatHub.ServeWS)
	})

	return api
}

func (api *ChatAPI) GetMessages(w http.ResponseWriter, r *http.Request) {
	messages, err := api.getMessagesUseCase.Execute(50)
	if err != nil {
		http.Error(w, "Erreur lors de la récupération des messages", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	_ = json.NewEncoder(w).Encode(messages)
}

// BuildChatMessageHandler retourne le handler onMessage pour le chat hub.
func BuildChatMessageHandler(sendMessageUseCase *usecases.SendMessageUseCase) func([]byte, *ws.Hub) {
	return func(raw []byte, hub *ws.Hub) {
		var incoming incomingChatMessage
		if err := json.Unmarshal(raw, &incoming); err != nil {
			log.Println("Chat: message JSON invalide:", err)
			return
		}
		if incoming.Content == "" || incoming.Author == "" {
			return
		}

		saved, err := sendMessageUseCase.Execute(incoming.Content, incoming.Author)
		if err != nil {
			log.Println("Chat: erreur sauvegarde message:", err)
			return
		}

		broadcast, err := json.Marshal(saved)
		if err != nil {
			log.Println("Chat: erreur sérialisation:", err)
			return
		}
		// Envoi non-bloquant depuis readPump : évite de bloquer la réception
		// de nouveaux messages si le canal Broadcast est saturé.
		hub.PublishLatest(broadcast)
	}
}

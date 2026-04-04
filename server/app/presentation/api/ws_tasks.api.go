package api

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/WilliamGroc/EventBox/app/domain/usecases"
	"github.com/WilliamGroc/EventBox/app/ws"
	"github.com/go-chi/chi/v5"
)

// NewTaskWsRoutes enregistre l'endpoint WebSocket pour les tasks.
// À la connexion, la liste complète des tasks est envoyée immédiatement.
func NewTaskWsRoutes(router *chi.Mux, taskHub *ws.Hub, getTasksUseCase *usecases.GetTasksUseCase) {
	router.Get("/ws/tasks", func(w http.ResponseWriter, r *http.Request) {
		initial, err := buildTasksPayload(getTasksUseCase)
		if err != nil {
			log.Println("WS Tasks: erreur récupération initiale:", err)
			initial = []byte("[]")
		}
		taskHub.ServeWSWithInitial(w, r, initial)
	})
}

// BroadcastTasks sérialise et diffuse la liste complète des tasks à tous les clients WS.
func BroadcastTasks(taskHub *ws.Hub, getTasksUseCase *usecases.GetTasksUseCase) {
	data, err := buildTasksPayload(getTasksUseCase)
	if err != nil {
		log.Println("WS Tasks: erreur broadcast:", err)
		return
	}
	taskHub.Broadcast <- data
}

func buildTasksPayload(getTasksUseCase *usecases.GetTasksUseCase) ([]byte, error) {
	tasks, err := getTasksUseCase.Execute()
	if err != nil {
		return nil, err
	}
	return json.Marshal(tasks)
}

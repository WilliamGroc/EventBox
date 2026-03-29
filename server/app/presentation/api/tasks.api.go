package api

import (
	"encoding/json"
	"net/http"

	"github.com/WilliamGroc/EventBox/app/domain/usecases"
	"github.com/go-chi/chi/v5"
)

type TaskAPI struct {
	Router *chi.Mux

	getTasksUseCase *usecases.GetTasksUseCase
}

type TaskAPIInterface interface {
	GetAllTasks(w http.ResponseWriter, r *http.Request)
	UpdateTask(w http.ResponseWriter, r *http.Request)
}

func NewTaskRoutes(router *chi.Mux, getTasksUseCase *usecases.GetTasksUseCase) *TaskAPI {
	api := &TaskAPI{
		Router:          router,
		getTasksUseCase: getTasksUseCase,
	}

	router.Route("/tasks", func(r chi.Router) {
		r.Get("/", api.GetAllTasks)
		r.Put("/{id}", api.UpdateTask)
	})

	return api
}

func (api *TaskAPI) GetAllTasks(w http.ResponseWriter, r *http.Request) {
	tasks, err := api.getTasksUseCase.Execute()
	if err != nil {
		http.Error(w, "Erreur lors de la récupération des tâches", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(tasks)
}

func (api *TaskAPI) UpdateTask(w http.ResponseWriter, r *http.Request) {
}

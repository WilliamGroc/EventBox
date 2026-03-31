package api

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/WilliamGroc/EventBox/app/domain/usecases"
	"github.com/go-chi/chi/v5"
)

type TaskAPI struct {
	Router *chi.Mux

	getTasksUseCase              *usecases.GetTasksUseCase
	updateIsCompletedTaskUseCase *usecases.UpdateIsCompletedTaskUseCase
}

type TaskAPIInterface interface {
	GetAllTasks(w http.ResponseWriter, r *http.Request)
	UpdateTask(w http.ResponseWriter, r *http.Request)
}

func NewTaskRoutes(router *chi.Mux,
	getTasksUseCase *usecases.GetTasksUseCase,
	updateIsCompletedTaskUseCase *usecases.UpdateIsCompletedTaskUseCase) *TaskAPI {
	api := &TaskAPI{
		Router:                       router,
		getTasksUseCase:              getTasksUseCase,
		updateIsCompletedTaskUseCase: updateIsCompletedTaskUseCase,
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
	taskIdStr := chi.URLParam(r, "id")
	taskId, err := strconv.ParseUint(taskIdStr, 10, 32)
	if err != nil {
		http.Error(w, "ID de tâche invalide", http.StatusBadRequest)
		return
	}

	var requestBody struct {
		IsCompleted bool `json:"isCompleted"`
	}
	err = json.NewDecoder(r.Body).Decode(&requestBody)
	if err != nil {
		http.Error(w, "Requête invalide", http.StatusBadRequest)
		return
	}
	err = api.updateIsCompletedTaskUseCase.Execute(uint(taskId), requestBody.IsCompleted)
	if err != nil {
		http.Error(w, "Erreur lors de la mise à jour de la tâche", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusNoContent)
}

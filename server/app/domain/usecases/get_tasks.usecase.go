package usecases

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
)

type GetTasksUseCase struct {
	taskRepository repositories.TaskRepository
}

func NewGetTasksUseCase(taskRepository repositories.TaskRepository) *GetTasksUseCase {
	return &GetTasksUseCase{taskRepository: taskRepository}
}

func (uc *GetTasksUseCase) Execute() ([]entities.Task, error) {
	tasks, err := uc.taskRepository.GetAllTasks()
	if err != nil {
		return nil, err
	}

	return tasks, nil
}

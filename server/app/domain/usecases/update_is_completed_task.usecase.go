package usecases

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
)

type UpdateIsCompletedTaskUseCase struct {
	taskRepository repositories.TaskRepository
}

func NewUpdateIsCompletedTaskUseCase(taskRepository repositories.TaskRepository) *UpdateIsCompletedTaskUseCase {
	return &UpdateIsCompletedTaskUseCase{taskRepository: taskRepository}
}

func (uc *UpdateIsCompletedTaskUseCase) Execute(taskId uint, isCompleted bool) error {
	task := &entities.Task{
		ID:          taskId,
		IsCompleted: isCompleted,
	}
	err := uc.taskRepository.UpdateTask(task)
	if err != nil {
		return err
	}

	return nil
}

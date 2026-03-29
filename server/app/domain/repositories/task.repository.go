package repositories

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
)

type TaskRepository interface {
	GetAllTasks() ([]entities.Task, error)
	UpdateTask(task *entities.Task) error
}

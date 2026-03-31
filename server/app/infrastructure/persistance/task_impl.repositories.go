package persistance

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
	"github.com/WilliamGroc/EventBox/app/infrastructure/models"
	"gorm.io/gorm"
)

type TaskRepositoryGorm struct {
	DB *gorm.DB
}

func NewTaskRepository(db *gorm.DB) repositories.TaskRepository {
	return &TaskRepositoryGorm{DB: db}
}

func (r *TaskRepositoryGorm) GetAllTasks() ([]entities.Task, error) {
	var tasks []models.TaskModel
	err := r.DB.Find(&tasks).Error
	if err != nil {
		return nil, err
	}

	var result []entities.Task = make([]entities.Task, 0, len(tasks))
	for _, task := range tasks {
		result = append(result, entities.Task{
			ID:          task.ID,
			Title:       task.Title,
			Description: task.Description,
			IsCompleted: task.IsCompleted,
			StartTime:   task.StartTime,
		})
	}
	return result, nil
}

func (r *TaskRepositoryGorm) UpdateTask(task *entities.Task) error {
	var taskModel models.TaskModel
	err := r.DB.First(&taskModel, task.ID).Error
	if err != nil {
		return err
	}

	taskModel.IsCompleted = task.IsCompleted

	err = r.DB.Save(&taskModel).Error
	if err != nil {
		return err
	}
	return nil
}

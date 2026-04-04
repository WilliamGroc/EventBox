package persistance

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
	"github.com/WilliamGroc/EventBox/app/infrastructure/models"
	"gorm.io/gorm"
)

type MessageRepositoryGorm struct {
	DB *gorm.DB
}

func NewMessageRepository(db *gorm.DB) repositories.MessageRepository {
	return &MessageRepositoryGorm{DB: db}
}

func (r *MessageRepositoryGorm) GetRecentMessages(limit int) ([]entities.Message, error) {
	var msgs []models.MessageModel
	err := r.DB.Order("created_at desc").Limit(limit).Find(&msgs).Error
	if err != nil {
		return nil, err
	}

	result := make([]entities.Message, 0, len(msgs))
	for i := len(msgs) - 1; i >= 0; i-- {
		m := msgs[i]
		result = append(result, entities.Message{
			ID:        m.ID,
			Content:   m.Content,
			Author:    m.Author,
			CreatedAt: m.CreatedAt,
		})
	}
	return result, nil
}

func (r *MessageRepositoryGorm) SaveMessage(message *entities.Message) (*entities.Message, error) {
	model := &models.MessageModel{
		Content: message.Content,
		Author:  message.Author,
	}
	err := r.DB.Create(model).Error
	if err != nil {
		return nil, err
	}
	return &entities.Message{
		ID:        model.ID,
		Content:   model.Content,
		Author:    model.Author,
		CreatedAt: model.CreatedAt,
	}, nil
}

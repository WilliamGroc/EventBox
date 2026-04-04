package repositories

import "github.com/WilliamGroc/EventBox/app/domain/entities"

type MessageRepository interface {
	GetRecentMessages(limit int) ([]entities.Message, error)
	SaveMessage(message *entities.Message) (*entities.Message, error)
}

package usecases

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
)

type GetMessagesUseCase struct {
	messageRepository repositories.MessageRepository
}

func NewGetMessagesUseCase(repo repositories.MessageRepository) *GetMessagesUseCase {
	return &GetMessagesUseCase{messageRepository: repo}
}

func (uc *GetMessagesUseCase) Execute(limit int) ([]entities.Message, error) {
	return uc.messageRepository.GetRecentMessages(limit)
}

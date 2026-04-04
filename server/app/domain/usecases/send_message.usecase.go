package usecases

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
)

type SendMessageUseCase struct {
	messageRepository repositories.MessageRepository
}

func NewSendMessageUseCase(repo repositories.MessageRepository) *SendMessageUseCase {
	return &SendMessageUseCase{messageRepository: repo}
}

func (uc *SendMessageUseCase) Execute(content, author string) (*entities.Message, error) {
	msg := &entities.Message{
		Content: content,
		Author:  author,
	}
	return uc.messageRepository.SaveMessage(msg)
}

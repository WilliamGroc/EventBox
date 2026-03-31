package usecases

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
)

type GetSongByIDUseCase struct {
	songRepository repositories.SongRepository
}

func NewGetSongByIDUseCase(songRepository repositories.SongRepository) *GetSongByIDUseCase {
	return &GetSongByIDUseCase{songRepository: songRepository}
}

func (uc *GetSongByIDUseCase) Execute(id uint) (*entities.Song, error) {
	song, err := uc.songRepository.GetSongByID(id)
	if err != nil {
		return nil, err
	}

	return song, nil
}

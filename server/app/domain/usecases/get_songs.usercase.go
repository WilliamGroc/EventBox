package usecases

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
)

type GetSongsUseCase struct {
	songRepository repositories.SongRepository
}

func NewGetSongsUseCase(songRepository repositories.SongRepository) *GetSongsUseCase {
	return &GetSongsUseCase{songRepository: songRepository}
}

func (uc *GetSongsUseCase) Execute() ([]entities.Song, error) {
	songs, err := uc.songRepository.GetAllSongs()
	if err != nil {
		return nil, err
	}

	return songs, nil
}

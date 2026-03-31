package repositories

import "github.com/WilliamGroc/EventBox/app/domain/entities"

type SongRepository interface {
	GetAllSongs() ([]entities.Song, error)
	GetSongByID(id uint) (*entities.Song, error)
}

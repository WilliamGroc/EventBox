package persistance

import (
	"github.com/WilliamGroc/EventBox/app/domain/entities"
	"github.com/WilliamGroc/EventBox/app/domain/repositories"
	"github.com/WilliamGroc/EventBox/app/infrastructure/models"
	"gorm.io/gorm"
)

type SongRepositoryGorm struct {
	DB *gorm.DB
}

func NewSongRepository(db *gorm.DB) repositories.SongRepository {
	return &SongRepositoryGorm{DB: db}
}

func (r *SongRepositoryGorm) GetAllSongs() ([]entities.Song, error) {
	var songs []models.SongModel
	err := r.DB.Find(&songs).Error
	if err != nil {
		return nil, err
	}

	var result []entities.Song = make([]entities.Song, 0, len(songs))
	for _, task := range songs {
		result = append(result, entities.Song{
			ID:       task.ID,
			Title:    task.Title,
			FileName: task.FileName,
			Moment:   task.Moment,
		})
	}
	return result, nil
}

func (r *SongRepositoryGorm) GetSongByID(id uint) (*entities.Song, error) {
	var songModel models.SongModel
	err := r.DB.First(&songModel, id).Error
	if err != nil {
		return nil, err
	}
	return &entities.Song{
		ID:       songModel.ID,
		Title:    songModel.Title,
		FileName: songModel.FileName,
		Moment:   songModel.Moment,
	}, nil
}

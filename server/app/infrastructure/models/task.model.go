package models

type TaskModel struct {
	ID          uint   `gorm:"primaryKey" json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	IsCompleted bool   `json:"is_completed" gorm:"default:false"`
	StartTime   string `json:"start_time"`
	SongID      uint   `json:"song_id" gorm:"default:0"`
}

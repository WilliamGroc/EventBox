package models

type SongModel struct {
	ID       uint   `gorm:"primaryKey" json:"id"`
	Title    string `gorm:"not null" json:"title"`
	FileName string `gorm:"not null" json:"fileName"`
}

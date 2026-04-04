package models

import "time"

type MessageModel struct {
	ID        uint      `gorm:"primaryKey" json:"id"`
	Content   string    `gorm:"not null" json:"content"`
	Author    string    `gorm:"not null" json:"author"`
	CreatedAt time.Time `json:"createdAt"`
}

package entities

type Task struct {
	ID          uint   `json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	IsCompleted bool   `json:"isCompleted"`
	StartTime   string `json:"startTime"`
	SongID      uint   `json:"songId"`
}

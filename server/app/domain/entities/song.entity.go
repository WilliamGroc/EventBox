package entities

type Song struct {
	ID       uint   `json:"id"`
	Title    string `json:"title"`
	FileName string `json:"fileName"`
	Moment   string `json:"moment"`
}

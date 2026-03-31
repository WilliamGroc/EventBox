package api

import (
	"encoding/json"
	"net/http"
	"os"
	"path/filepath"
	"strconv"

	"github.com/WilliamGroc/EventBox/app/domain/usecases"
	"github.com/go-chi/chi/v5"
)

type SongApi struct {
	Router *chi.Mux

	getSongsUseCase     *usecases.GetSongsUseCase
	getSongByIDUserCase *usecases.GetSongByIDUseCase
}

type SongApiInterface interface {
	GetAllSongs(w http.ResponseWriter, r *http.Request)
	DownloadSong(w http.ResponseWriter, r *http.Request)
}

func NewSongRoutes(
	router *chi.Mux,
	getSongsUseCase *usecases.GetSongsUseCase,
	getSongByIDUserCase *usecases.GetSongByIDUseCase,
) *SongApi {
	api := &SongApi{
		Router:              router,
		getSongsUseCase:     getSongsUseCase,
		getSongByIDUserCase: getSongByIDUserCase,
	}

	router.Route("/songs", func(r chi.Router) {
		r.Get("/", api.GetAllSongs)
		r.Get("/{id}/download", api.DownloadSong)
	})

	return api
}

func (api *SongApi) GetAllSongs(w http.ResponseWriter, r *http.Request) {
	songs, err := api.getSongsUseCase.Execute()
	if err != nil {
		http.Error(w, "Erreur lors de la récupération des chansons", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(songs)
}

func (api *SongApi) DownloadSong(w http.ResponseWriter, r *http.Request) {
	fileIdStr := chi.URLParam(r, "id")
	fileId, err := strconv.Atoi(fileIdStr)
	if err != nil {
		http.Error(w, "ID de chanson invalide", http.StatusBadRequest)
		return
	}

	song, err := api.getSongByIDUserCase.Execute(uint(fileId))
	if err != nil {
		http.Error(w, "Chanson non trouvée", http.StatusNotFound)
		return
	}

	cheminFichier := filepath.Join("./static", song.FileName)
	if _, err := os.Stat(cheminFichier); os.IsNotExist(err) {
		http.NotFound(w, r)
		return
	}

	http.ServeFile(w, r, cheminFichier)
}

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/WilliamGroc/EventBox/app"
	"github.com/joho/godotenv"
)

func main() {
	// Charger le fichier .env
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Erreur lors du chargement du fichier .env")
	}

	container := app.NewContainer()

	port := os.Getenv("PORT")
	fmt.Printf("Serveur démarré sur http://localhost:%s\n", port)
	err = http.ListenAndServe(":"+port, container.Router)
	if err != nil {
		log.Fatal("Erreur lors du démarrage du serveur : ", err)
	}
}

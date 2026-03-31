package app

import (
	"fmt"
	"log"
	"os"

	"github.com/WilliamGroc/EventBox/app/domain/usecases"
	"github.com/WilliamGroc/EventBox/app/infrastructure/models"
	"github.com/WilliamGroc/EventBox/app/infrastructure/persistance"
	"github.com/WilliamGroc/EventBox/app/presentation/api"
	"github.com/glebarez/sqlite"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"
	"gorm.io/gorm"
)

type Container struct {
	DB     *gorm.DB
	Router *chi.Mux
}

type ContainerInterface interface {
	NewContainer() *Container
}

func initDatabase() *gorm.DB {
	// Utiliser les variables
	dbURL := os.Getenv("DATABASE_URL")

	db, err := gorm.Open(sqlite.Open(dbURL), &gorm.Config{})
	if err != nil {
		log.Fatal("Erreur de connexion à la base de données : ", err)
	}

	fmt.Println("Connecté à la base de données SQLite avec GORM !")

	// Migrer le schéma (créer les tables)
	err = db.AutoMigrate(&models.TaskModel{})
	if err != nil {
		log.Fatal("Erreur de migration : ", err)
	}

	return db
}

func initRouter() *chi.Mux {
	r := chi.NewRouter()
	r.Use(middleware.Logger)

	r.Use(cors.Handler(cors.Options{
		AllowedOrigins:   []string{"https://*", "http://*"}, // Autorise tous les origines (à adapter en production)
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type", "X-CSRF-Token"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: true,
		MaxAge:           300, // Cache la réponse preflight pendant 5 minutes
	}))

	return r
}

func NewContainer() *Container {
	// Initialize your dependencies here, for example:
	db := initDatabase()
	router := initRouter()

	container := &Container{
		DB:     db,
		Router: router,
	}

	// Repositories
	taskRepository := persistance.NewTaskRepository(db)

	// Use Cases
	getTaskUserCase := usecases.NewGetTasksUseCase(taskRepository)
	updateIsCompletedTaskUseCase := usecases.NewUpdateIsCompletedTaskUseCase(taskRepository)

	// API Routes
	api.NewTaskRoutes(router, getTaskUserCase, updateIsCompletedTaskUseCase)

	return container
}

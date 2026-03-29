package app

import (
	"fmt"
	"log"
	"os"

	"github.com/WilliamGroc/EventBox/app/domain/usecases"
	"github.com/WilliamGroc/EventBox/app/infrastructure/models"
	"github.com/WilliamGroc/EventBox/app/infrastructure/persistance"
	"github.com/WilliamGroc/EventBox/app/presentation/api"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"gorm.io/driver/sqlite"
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

	taskRepository := persistance.NewTaskRepository(db)

	getTaskUserCase := usecases.NewGetTasksUseCase(taskRepository)

	api.NewTaskRoutes(router, getTaskUserCase)

	return container
}

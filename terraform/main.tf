terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_container" "frontend" {
  name  = "frontend"
  image = "my-frontend-app:v1"

  restart = "always"

  ports {
    internal = 80
    external = 8080
  }
}

resource "docker_container" "backend" {
  name  = "backend"
  image = "my-backend-app:v1"

  restart = "always"

  ports {
    internal = 3000
    external = 3000
  }

  env = [
    "PORT=3000",
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PW}",
    "POSTGRES_DB=${var.POSTGRES_DB}",
  ]

  depends_on = [docker_container.postgres]
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = "postgres:15.4"

  restart = "always"
  ports {
    internal = 5432
    external = 5432
  }

  env = [
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PW}",
    "POSTGRES_DB=${var.POSTGRES_DB}",
  ]
}

resource "docker_container" "pgadmin" {
  name  = "pgadmin"
  image = "dpage/pgadmin4:latest"

  restart = "always"

  ports {
    internal = 80
    external = 5050
  }

  env = [
    "PGADMIN_DEFAULT_EMAIL=${var.PGADMIN_MAIL}",
    "PGADMIN_DEFAULT_PASSWORD=${var.PGADMIN_PW}",
  ]
}
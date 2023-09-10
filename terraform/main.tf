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

resource "docker_network" "mynetwork" {
  name = var.network_name
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = var.postgres_image

  restart = "always"

  ports {
    internal = var.postgres_internal_port
    external = var.postgres_external_port
  }

  env = [
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PW}",
    "POSTGRES_DB=${var.POSTGRES_DB}",
  ]

  volumes {
    host_path      = "/var/lib/postgresql/data"
    container_path = "/docker-entrypoint-initdb.d"
  }

  networks_advanced {
    name = docker_network.mynetwork.name
  }
}

resource "docker_container" "pgadmin4" {
  name  = "pgadmin4"
  image = var.pgadmin_image

  restart = "always"

  ports {
    internal = var.pgadmin_internal_port
    external = var.pgadmin_external_port
  }

  env = [
    "PGADMIN_DEFAULT_EMAIL=${var.PGADMIN_MAIL}",
    "PGADMIN_DEFAULT_PASSWORD=${var.PGADMIN_PW}",
  ]

  networks_advanced {
    name = docker_network.mynetwork.name
  }
}

resource "docker_container" "frontend" {
  name  = "frontend"
  image = var.frontend_image

  restart = "always"

  ports {
    internal = var.frontend_internal_port
    external = var.frontend_external_port
  }

  networks_advanced {
    name = docker_network.mynetwork.name
  }
}

resource "docker_container" "backend" {
  name  = "backend"
  image = var.backend_image

  restart = "always"

  ports {
    internal = var.backend_internal_port
    external = var.backend_external_port
  }

  networks_advanced {
    name = docker_network.mynetwork.name
  }
}

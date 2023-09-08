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
  name = "mynetwork"
}

resource "docker_container" "frontend" {
  name  = "frontend"
  image = "my-frontend-app:v1"

  restart = "always"

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.mynetwork.name
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

  networks_advanced {
    name = docker_network.mynetwork.name
  }
}

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
  name  = "frontend-app"
  image = "my-frontend-app:0.1.1"
  ports {
    internal = 80
    external = 8080
  }
}

resource "docker_container" "backend" {
  name  = "backend-app"
  image = "my-backend-app:0.1.1"
  ports {
    internal = 3000
    external = 3000
  }
}

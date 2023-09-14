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
  name    = "pgadmin4"
  image   = var.pgadmin_image
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
  name    = "frontend"
  image   = var.frontend_image
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
  name    = "backend"
  image   = var.backend_image
  restart = "always"

  ports {
    internal = var.backend_internal_port
    external = var.backend_external_port
  }

  networks_advanced {
    name = docker_network.mynetwork.name
  }
}

resource "null_resource" "initialize_database" {
  provisioner "local-exec" {
    command = <<EOT
      until docker exec ${docker_container.postgres.name} pg_isready -h localhost -p 5432 -U ${var.POSTGRES_USER}; do
        echo "Waiting for PostgreSQL to become available..."
        sleep 2
      done

      docker exec -i ${docker_container.postgres.name} psql -U ${var.POSTGRES_USER} -d ${var.POSTGRES_DB} -c "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, username VARCHAR(50) NOT NULL, password VARCHAR(255) NOT NULL, role VARCHAR(20) NOT NULL);"
      docker exec -i ${docker_container.postgres.name} psql -U ${var.POSTGRES_USER} -d ${var.POSTGRES_DB} -c "INSERT INTO users (username, password, role) VALUES ('admin', 'secure_p4$$w0rd', 'admin');"
    EOT
  }
}

resource "null_resource" "inspect_postgres_container" {
  triggers = {
    container_id = docker_container.postgres.id
  }

  provisioner "local-exec" {
    command = <<EOT
      container_ip=$(docker inspect -f '{{.NetworkSettings.Networks.mynetwork.IPAddress}}' postgres)
      echo "$container_ip" > "${path.module}/ip_output.txt"
    EOT
  }
}

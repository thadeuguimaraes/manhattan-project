variable "frontend_image" {
  description = "Nome da imagem do contêiner frontend"
  default     = "my-frontend-app:v1"
}

variable "backend_image" {
  description = "Nome da imagem do contêiner backend"
  default     = "my-backend-app:v1"
}

variable "postgres_image" {
  description = "Nome da imagem do contêiner PostgreSQL"
  default     = "postgres:15.4"
}

variable "pgadmin_image" {
  description = "Nome da imagem do contêiner pgAdmin 4"
  default     = "dpage/pgadmin4:latest"
}

variable "network_name" {
  description = "Nome da rede Docker"
  default     = "mynetwork"
}

variable "POSTGRES_USER" {
  description = "Nome de usuário do PostgreSQL"
  default     = "cubos"
}

variable "POSTGRES_PW" {
  description = "Senha do PostgreSQL"
  default     = "cubos_net"
}

variable "POSTGRES_DB" {
  description = "Nome do banco de dados PostgreSQL"
  default     = "postgres"
}

variable "PGADMIN_MAIL" {
  description = "E-mail do pgAdmin"
  default     = "mtguimaraes84@gmail.com"
}

variable "PGADMIN_PW" {
  description = "Senha do pgAdmin"
  default     = "canes123"
}

variable "postgres_internal_port" {
  description = "Porta interna do Postgres"
  default     = 5431
}

variable "postgres_external_port" {
  description = "Porta externa do Postgres"
  default     = 5432
}

variable "pgadmin_internal_port" {
  description = "Porta interna do PgAdmin"
  default     = 80
}

variable "pgadmin_external_port" {
  description = "Porta externa do PgAdmin"
  default     = 5050
}

variable "frontend_internal_port" {
  description = "Porta interna do Frontend"
  default     = 80
}

variable "frontend_external_port" {
  description = "Porta externa do Frontend"
  default     = 8080
}

variable "backend_internal_port" {
  description = "Porta interna do Backend"
  default     = 3000
}

variable "backend_external_port" {
  description = "Porta externa do Backend"
  default     = 3000
}

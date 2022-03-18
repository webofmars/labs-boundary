variable "postgres_admin_username" {
  type    = string
  default = "postgres"
}

variable "postgres_admin_password" {
  type    = string
  default = "postgres"
}

variable "postgres_host" {
  type    = string
  default = "postgres"
}

variable "postgres_port" {
  type    = number
  default = 5432
}

variable "postgres_database" {
  type    = string
  default = "boundary"
}

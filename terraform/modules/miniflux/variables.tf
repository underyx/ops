variable "miniflux_admin_password" {
  type        = string
  sensitive = true
  description = "Admin password for miniflux web UI"
}

variable "postgres_password" {
  type        = string
  sensitive = true
  description = "Postgres database password"
}

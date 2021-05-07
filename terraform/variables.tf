locals {
  ips = {
    unicorn_public      = "144.76.111.239"
    unicorn_public_ipv6 = "2a01:4f8:192:61ee::2"
    unicorn_tailscale   = "100.67.90.29"
  }
}

variable "cloudflare_api_token" {
  type        = string
  sensitive = true
  description = "Cloudflare API token, needs Zone:Edit, DNS:Edit"
}

variable "plex_claim_token" {
  type        = string
  sensitive = true
  description = "Token from https://www.plex.tv/claim/"
}

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

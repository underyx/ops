module "cloudflare" {
  source = "./modules/cloudflare"
  ips    = local.ips
  providers = {
    cloudflare = cloudflare
  }
}

module "caddy" {
  source               = "./modules/caddy"
  cloudflare_api_token = var.cloudflare_api_token
  self_internal_ip = local.ips.unicorn_tailscale
  providers = {
    nomad = nomad
  }
}

module "media" {
  source = "./modules/media"
  plex_claim_token = var.plex_claim_token
  providers = {
    nomad = nomad
  }
}

module "images" {
  source = "./modules/images"
  providers = {
    nomad = nomad
  }
}

module "db" {
  source = "./modules/db"
  postgres_password = var.postgres_password
  providers = {
    nomad = nomad
  }
}

module "miniflux" {
  source = "./modules/miniflux"
  postgres_password = var.postgres_password
  miniflux_admin_password = var.miniflux_admin_password
  providers = {
    nomad = nomad
  }
}

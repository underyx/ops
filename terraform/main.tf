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

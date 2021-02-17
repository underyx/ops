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
  providers = {
    nomad = nomad
  }
}

module "public" {
  source = "./modules/public"
  providers = {
    nomad = nomad
  }
}

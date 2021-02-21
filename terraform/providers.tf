provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "nomad" {
  # DNS record is missing when first applying, gotta use IP address
  address = "http://${local.ips.unicorn_tailscale}:4646"
}

locals {
  ips = {
    unicorn_public      = "144.76.111.239"
    unicorn_public_ipv6 = "2a01:4f8:192:61ee::2"
  }
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token, needs Zone:Edit, DNS:Edit"
}

variable "self_internal_ip" {
  type = string
  description = "IP address where Nomad and Consul are available"
}

variable "cloudflare_api_token" {
  type        = string
  sensitive = true
  description = "Cloudflare API token to edit DNS Zones and Records."
}

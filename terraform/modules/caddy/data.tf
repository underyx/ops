data "template_file" "caddyfile-internal" {
  template = file("${path.module}/conf/Caddyfile-internal")
  vars = {
    cloudflare_api_token = var.cloudflare_api_token
    self_internal_ip = var.self_internal_ip
  }
}

data "template_file" "caddyfile-public" {
  template = file("${path.module}/conf/Caddyfile-public")
  vars = {
    cloudflare_api_token = var.cloudflare_api_token
    self_internal_ip = var.self_internal_ip
  }
}

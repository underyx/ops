resource "cloudflare_record" "unicorn" {
  zone_id = cloudflare_zone.underyx_me.id

  name    = "unicorn"
  type    = "A"
  ttl     = "1"
  proxied = "false"

  value = var.ips["unicorn_public"]
}

resource "cloudflare_record" "unicorn_ipv6" {
  zone_id = cloudflare_zone.underyx_me.id

  name    = "unicorn"
  type    = "AAAA"
  ttl     = "1"
  proxied = "false"

  value = var.ips["unicorn_public_ipv6"]
}

resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.underyx_me.id

  name    = "@"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "unicorn.underyx.me"
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.underyx_me.id

  name    = "www"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "unicorn.underyx.me"
}

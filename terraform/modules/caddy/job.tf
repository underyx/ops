resource "nomad_job" "app" {
  jobspec = templatefile("${path.module}/conf/caddy.nomad", {
    caddyfile = data.template_file.caddyfile.rendered
  })
  hcl2 {
    enabled = true
  }
}

resource "nomad_job" "miniflux" {
  jobspec = templatefile("${path.module}/conf/miniflux.nomad", {
    postgres_password = var.postgres_password
    miniflux_admin_password = var.miniflux_admin_password
  })
  hcl2 {
    enabled = true
  }
}

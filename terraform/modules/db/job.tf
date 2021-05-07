resource "nomad_job" "db" {
  jobspec = templatefile("${path.module}/conf/db.nomad", {
    postgres_password = var.postgres_password
  })
  hcl2 {
    enabled = true
  }
}

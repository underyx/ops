resource "nomad_job" "images" {
  jobspec = file("${path.module}/conf/images.nomad")
  hcl2 {
    enabled = true
  }
}

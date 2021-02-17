resource "nomad_job" "app" {
  jobspec = file("${path.module}/conf/public.nomad")
  hcl2 {
    enabled = true
  }
}

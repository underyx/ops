resource "nomad_job" "plex" {
  jobspec = templatefile("${path.module}/conf/plex.nomad", {
    plex_claim_token = var.plex_claim_token
  })
  hcl2 {
    enabled = true
  }
}

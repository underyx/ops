data_dir  = "/opt/nomad/data"
datacenter = "unicorn"

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled       = true
  options = {
    "docker.volumes.enabled" = true,
    "driver.raw_exec.enable" = "1"
  }
}

data_dir  = "/opt/nomad/data"
bind_addr = "{{ GetInterfaceIP \"tailscale0\" }}"
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

  reserved {
    reserved_ports = "22"
  }

  host_network "tailscale" {
    cidr = "100.67.90.29/32"
  }
}

consul {
  address = "100.67.90.29:8500"
}

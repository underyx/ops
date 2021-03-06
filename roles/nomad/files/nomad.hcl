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
    "docker.volumes.enabled" = true
  }

  reserved {
    reserved_ports = "22"
  }

  host_network "tailscale" {
    cidr = "100.64.0.0/10"
    interface = "tailscale0"
  }

  host_network "public" {
    cidr = "144.76.111.225/32"
    reserved_ports = "22"
  }
}

consul {
  address = "{{ GetInterfaceIP \"tailscale0\" }}:8500"
}

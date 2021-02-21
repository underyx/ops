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
  host_network "tailscale" {
    cidr = "{{ GetInterfaceIP \"tailscale0\" }}/32"
    reserved_ports = "22"
  }
}

consul {
  address = "{{ GetInterfaceIP \"tailscale0\" }}:8500"
}

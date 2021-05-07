job "images" {
  datacenters = ["unicorn"]
  type        = "service"

  group "web" {
    count = 1

    network {
      port "http" {
        to = 80
      }
    }

    restart {
      attempts = 2
      interval = "2m"
      delay    = "30s"
      mode     = "fail"
    }

    task "web" {
      driver = "docker"

      service {
        name = "images-web"
        port = "http"
      }

      config {
        image = "nginx:1.16-alpine"

        ports = ["http"]

        mount {
          type     = "bind"
          target   = "/usr/share/nginx/html"
          source   = "/data/images/public"
          readonly = true
        }
      }

      resources {
        cpu    = 50
        memory = 200
      }
    }
  }

  group "ssh" {
    count = 1

    network {
      port "ssh" {
        to = 22
        host_network = "tailscale"
      }
    }

    restart {
      attempts = 2
      interval = "2m"
      delay    = "30s"
      mode     = "fail"
    }

    task "ssh" {
      driver = "docker"

      service {
        name = "images-ssh"
        port = "ssh"
      }

      config {
        image = "panubo/sshd:1.3.0"

        ports = ["ssh"]

        mount {
          type     = "bind"
          target   = "/data/images/public"
          source   = "/data/images/public"
          readonly = false
        }

        mount {
          type     = "bind"
          target   = "/etc/ssh"
          source   = "/data/images/ssh"
          readonly = false
        }

      }

      template {
        data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNmV2+ahvVrnOD3uhyQ3ujdEFLmSthwBQxRX4BHtLfeDAQmQAnS+eELM1dw4TB8/NnOEHU8CbX7aOz/hKUHlvFpII3f+Q7C7lUcwT9AHr9ptfYy1w+Qus6Mh/i1alJrn7wwmRIdTjRDoedCs0vgGJ6OrbK9w76nAisBigRbB16TilP4cmIQHFuJfYCKEy3iAxKiwg3xzyFwoD/BYr5JGDL7HnxyxcLSb8F0h0H4aICUHGIbLWozTK14D0InbX7T1RlEnxmLLFZYe5f3YQivfQqMMbWl+y4nuTZu9IjKARnndSNzvKxmySWy+ivrpYmLRoEwgfo1QWTYLEx8pK/zRhJ monosnap@unicorn.underyx.me"

        destination = "/etc/authorized_keys"
      }

      resources {
        cpu    = 50
        memory = 200
      }
    }
  }
}

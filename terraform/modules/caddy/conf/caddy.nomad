job "caddy" {
  datacenters = ["unicorn"]
  type        = "service"

  group "proxy" {
    count = 1

    network {
      port "https-public" {
        static = 80
        to     = 80
      }

      port "http-public" {
        static = 443
        to     = 443
      }
    }

    restart {
      attempts = 2
      interval = "2m"
      delay    = "30s"
      mode     = "fail"
    }

    task "internal" {
      driver = "docker"

      config {
        image = "caddy:2.2.1-alpine"

        # Bind the config file to container.
        mount {
          type   = "bind"
          source = "configs"
          target = "/etc/caddy" # Bind mount the template from `NOMAD_TASK_DIR`.
        }

        # Bind the data directory to preserve certs.
        mount {
          type     = "bind"
          target   = "/data"
          source   = "/data/caddy"
          readonly = false
        }

        ports = ["http-public", "https-public"]
      }

      resources {
        cpu    = 100
        memory = 100
      }

      template {
        data = <<EOF
${caddyfile}
EOF

        destination = "configs/Caddyfile" # Rendered template.

        # Caddy doesn't support reload via signals
        change_mode = "restart"
      }
    }
  }
}

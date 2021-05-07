job "miniflux" {
  datacenters = ["unicorn"]
  type        = "service"

  group "web" {
    count = 1

    network {
      port "http" {
        to = 8080
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
        name = "miniflux-web"
        port = "http"
      }

      config {
        image = "miniflux/miniflux:2.0.29"
        ports = ["http"]
      }

      env {
        RUN_MIGRATIONS = "1"
        CREATE_ADMIN = "1"
        BASE_URL = "https://news.underyx.me/"
        HTTPS = "1"
        ADMIN_USERNAME = "underyx"
        ADMIN_PASSWORD = "${miniflux_admin_password}"
      }

      template {
        data = <<EOF
          {{- with service "db" }}
          {{- with index . 0 }}
          DATABASE_URL="postgres://postgres:${postgres_password}@{{.Address}}:{{.Port}}/miniflux?sslmode=disable"
          {{- end }}
          {{ end }}
        EOF

        destination = "secrets/config.env"
        env         = true
        change_mode = "restart"
      }

      resources {
        cpu    = 200
        memory = 500
      }
    }
  }
}

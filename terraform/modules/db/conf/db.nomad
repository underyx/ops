job "db" {
  datacenters = ["unicorn"]
  type        = "service"

  group "db" {
    count = 1

    network {
      port "postgres" {
        to = 5432
        host_network = "tailscale"
     }
    }

    restart {
      attempts = 2
      interval = "2m"
      delay    = "30s"
      mode     = "fail"
    }

    task "db" {
      driver = "docker"

      service {
        name = "db"
        port = "postgres"
      }

      config {
        image = "postgres:13-alpine"

        ports = ["postgres"]

        mount {
          type     = "bind"
          target   = "/var/lib/postgresql/data"
          source   = "/data/db"
        }
      }
      env {
        POSTGRES_PASSWORD = "${postgres_password}"
      }

      resources {
        cpu    = 300
        memory = 500
      }
    }
  }
}

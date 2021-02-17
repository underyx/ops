job "public" {
  datacenters = ["unicorn"]
  type        = "service"

  group "underyx-me" {
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
        name = "underyx-me"
        port = "http"
      }

      config {
        image = "underyx/underyx-me"
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 100
      }
    }
  }
}

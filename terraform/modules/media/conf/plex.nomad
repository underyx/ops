job "plex" {
  datacenters = ["unicorn"]
  type        = "service"

  group "app" {
    count = 1

    network {
      port "http" {
        to = 32400
        host_network = "tailscale"
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
        name = "plex"
        port = "http"
      }

      config {
        image = "plexinc/pms-docker:public"

        ports = ["http"]

        mount {
          type     = "bind"
          target   = "/config"
          source   = "/data/media/plex/config"
          readonly = false
        }

        mount {
          type     = "bind"
          target   = "/media"
          source   = "/data/media/common"
          readonly = false
        }
      }

      env {
        PLEX_UID = 797
        PLEX_GID = 797
        PLEX_CLAIM_TOKEN = "${plex_claim_token}"
      }

      resources {
        cpu    = 500
        memory = 500
      }
    }
  }
}

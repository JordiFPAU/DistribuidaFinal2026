job "book-store" {
  datacenters = ["dc1"]

  group "servers" {

    count = 4

    network {
      port "http" {}
    }

    task "app-customers" {
      driver = "java"

        artifact {
            source = "https://github.com/JordiFPAU/Distribuida2026/releases/download/VERSION_1.0.0/app-customers-0.0.1-SNAPSHOT.zip"
            destination = "local/app-customers-0.0.1-SNAPSHOT.jar"
        }

      config {
        #jar_path = "C:/Distribuida26_26/app-customers-0.0.1-SNAPSHOT.jar"
        jar_path = "local/app-customers-0.0.1-SNAPSHOT.jar"
        jvm_options = ["-Xmx1024m", "-Xms128m"]
      }

      env {
        SERVER_PORT = "${NOMAD_PORT_http}"
        SPRING_CLOUD_CONSUL_HOST = "192.168.30.20"
      }

      service {
        provider = "nomad"
        name     = "app-customers"
        port     = "http"
      }
    }
  }
}


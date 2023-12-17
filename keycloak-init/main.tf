resource "docker_image" "postgresql" {
  name         = "postgres:latest"
  keep_locally = true
}

resource "docker_container" "postgres" {
  image   = docker_image.postgresql.image_id
  name    = "kk_pg"
  env     = ["POSTGRES_PASSWORD=postgres"]
  ports {
    internal = 5432
    external = 6432
  }
}


resource "null_resource" "previous" {}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [null_resource.previous]
  create_duration = "5s"
}

resource "null_resource" "next" {
  depends_on = [time_sleep.wait_10_seconds]
}



resource "postgresql_database" "keycloak" {
  name              = "keycloak"
  owner             = "postgres"
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
  
  depends_on = [ null_resource.next]
}

resource "docker_image" "keycloak" {
  name         = "kk:1.0"
  keep_locally = true
}


resource "docker_container" "keycloak" {
  image   = docker_image.keycloak.image_id
  name    = "kk_poc"
  command = ["start --optimized"]
  env     = ["KEYCLOAK_ADMIN=admin", "KEYCLOAK_ADMIN_PASSWORD=admin"]

  ports {
    internal = 8443
    external = 8443
  }
}

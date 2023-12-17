terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    postgresql = {
      source = "doctolib/postgresql"
      version = "2.22.0"
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.3.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.2"
    }
  }
}

provider "docker" {
  host     = var.sshc
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

provider "postgresql" {
  host            = var.pg
  port            = 6432
  database        = var.pgdata
  username        = var.pgdata
  password        = var.pgdata
  sslmode         = "disable"
  connect_timeout = 1500
}
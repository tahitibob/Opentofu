variable sshc {
  type        = string
  default     = "ssh://root@192.168.1.100:22"
  description = "ssh connexion"
}

variable pg {
  type        = string
  default     = "192.168.1.100"
  description = "postgresql host"
}
variable pgdata {
  type        = string
  default     = "postgres"
  description = "unify pg data"
}

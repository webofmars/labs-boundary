variable "boundary_controller_policy" {
  type    = string
  default = <<EOT
  path "auth/token/lookup-self" {
    capabilities = ["read"]
  }

  path "auth/token/renew-self" {
    capabilities = ["update"]
  }

  path "auth/token/revoke-self" {
    capabilities = ["update"]
  }

  path "sys/leases/renew" {
    capabilities = ["update"]
  }

  path "sys/leases/revoke" {
    capabilities = ["update"]
  }

  path "sys/capabilities-self" {
    capabilities = ["update"]
  }

  path "database/creds/boundary" {
    capabilities = ["read"]
  }

  path "database/creds/boundary-admin" {
    capabilities = ["read"]
  }

  path "local-kms/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
  }
  EOT
}

variable "vault_kubernetes_auth_path" {
  type    = string
  default = "kubernetes"
}

variable "k8s_namespace" {
  type = string
  default = "default"
}

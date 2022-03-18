# variable "k8s_namespace" {
#   type    = string
#   default = "default"
# }

# variable "kubeconfig_path" {
#   type = string
#   default = "~/.kube/config"
# }

variable "boundary_addr" {
  type = string
}

# variable "boundary_auth_method_id" {
#   type = string
# }

variable "boundary_login" {
  type = string
}

variable "boundary_password" {
  type = string
}

# variable "project_scope_id" {
#   type = string
# }

# variable "org_scope_id" {
#   type = string
# }

variable "oidc_api_url_prefix" {
  type = string
}

variable "oidc_client_secret" {
  type = string
}

variable "oidc_client_id" {
  type = string
}

variable "admins_group_filter" {
  type = string
}

# variable "postgres_admin_username" {
#   type    = string
#   default = "postgres"
# }

# variable "postgres_admin_password" {
#   type    = string
#   default = "postgres"
# }

# variable "postgres_host" {
#   type    = string
#   default = "postgres"
# }

# variable "postgres_port" {
#   type    = number
#   default = 5432
# }

# variable "postgres_database" {
#   type    = string
#   default = "boundary"
# }

variable "boundary_vault_policy_file" {
  type    = string
  default = "./vault-boundary-policy.hcl"
}

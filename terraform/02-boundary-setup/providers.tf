provider "kubernetes" {
  config_paths = [
    var.kubeconfig_path,
  ]
}

provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables described above, so that each user can have
  # separate credentials set in the environment.
  #
  # This will default to using $VAULT_ADDR
  # But can be set explicitly
  # address = "https://vault.example.net:8200"
}

provider "boundary" {
  addr = var.boundary_addr
  # auth_method_id                  = var.boundary_auth_method_id
  # password_auth_method_login_name = var.boundary_login
  # password_auth_method_password   = var.boundary_password
  tls_insecure     = true
  recovery_kms_hcl = "../../.secrets/recovery.hcl"
}

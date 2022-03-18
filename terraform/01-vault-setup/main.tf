module "database_secrets" {
  source                  = "../modules/01-database-secrets"
  postgres_host           = var.postgres_host
  postgres_admin_password = var.postgres_admin_password
}

module "local_kms" {
  source = "../modules/02-local-kms"
}

module "auth_kubernetes" {
  source    = "../modules/03-auth-kubernetes"
  namespace = var.k8s_namespace
}

module "boundary_vault" {
  depends_on = [
    module.database_secrets,
    module.local_kms,
    module.auth_kubernetes,
  ]

  source                     = "../modules/04-boundary-vault"
  k8s_namespace              = var.k8s_namespace
  boundary_controller_policy = file("${path.module}/${var.boundary_vault_policy_file}")
}

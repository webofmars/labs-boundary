# module "boundary_vault" {
#   depends_on = [
#     module.database_secrets,
#     module.local_kms,
#     module.auth_kubernetes,
#   ]

#   source                     = "./04-boundary-vault"
#   k8s_namespace              = var.k8s_namespace
#   boundary_controller_policy = file("${path.module}/${var.boundary_vault_policy_file}")
# }

module "boundary_setup" {
  depends_on = [
    # module.database_secrets,
    # module.local_kms,
    # module.auth_kubernetes,
    # module.boundary_vault,
  ]
  source = "../modules/10-boundary-setup"
}

module "oidc_google" {
  depends_on = [
    # module.database_secrets,
    # module.local_kms,
    # module.auth_kubernetes,
    # module.boundary_vault,
    module.boundary_setup,
  ]

  source = "../modules/11-oidc"

  project_scope_id    = module.boundary_setup.projects["demo"].scope_id
  org_scope_id        = module.boundary_setup.default_organization.scope_id
  oidc_api_url_prefix = var.oidc_api_url_prefix
  oidc_client_secret  = var.oidc_client_secret
  oidc_client_id      = var.oidc_client_id
  admins_group_filter = var.admins_group_filter
}

resource "vault_policy" "boundary_controller" {
  name   = "boundary-controller"
  policy = var.boundary_controller_policy
}

resource "vault_token" "boundary_controller" {
  display_name = "boundary-controller"

  policies = [vault_policy.boundary_controller.name]

  no_parent         = true
  no_default_policy = true
  renewable         = true
  ttl               = "24h"
}

resource "vault_kubernetes_auth_backend_role" "boundary" {
  backend                          = var.vault_kubernetes_auth_path
  role_name                        = "boundary"
  bound_service_account_names      = ["boundary"]
  bound_service_account_namespaces = [var.k8s_namespace]
  token_ttl                        = 86400
  token_policies                   = [vault_policy.boundary_controller.name]
}

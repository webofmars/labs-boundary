data "kubernetes_service_account" "vault" {
  metadata {
    name      = "vault"
    namespace = "labs"
  }
}

data "kubernetes_secret" "vault_token" {
  metadata {
    name      = data.kubernetes_service_account.vault.default_secret_name
    namespace = var.namespace
  }
}

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "k8s" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default:443"
  kubernetes_ca_cert     = data.kubernetes_secret.vault_token.data["ca.crt"]
  token_reviewer_jwt     = data.kubernetes_secret.vault_token.data["token"]
  issuer                 = "https://kubernetes.default.svc.cluster.local"
  # disable_iss_validation = "true"
}

resource "vault_mount" "transit" {
  path                      = "local-kms"
  type                      = "transit"
  description               = "local kms"
  default_lease_ttl_seconds = 14400
  max_lease_ttl_seconds     = 14400
}

resource "vault_transit_secret_backend_key" "root" {
  name    = "root"
  backend = vault_mount.transit.path
  type    = "aes256-gcm96"
}

resource "vault_transit_secret_backend_key" "recovery" {
  name    = "recovery"
  backend = vault_mount.transit.path
  type    = "aes256-gcm96"
}

resource "vault_transit_secret_backend_key" "worker-auth" {
  name    = "worker-auth"
  backend = vault_mount.transit.path
  type    = "aes256-gcm96"
}

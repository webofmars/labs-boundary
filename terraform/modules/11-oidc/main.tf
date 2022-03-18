resource "boundary_auth_method_oidc" "google" {
  name                 = "Google"
  description          = "OIDC auth method for Google"
  scope_id             = var.org_scope_id
  issuer               = "https://accounts.google.com"
  client_id            = var.oidc_client_id
  client_secret        = var.oidc_client_secret
  signing_algorithms   = ["RS256"]
  api_url_prefix       = var.oidc_api_url_prefix
  state                = "active-public"
  is_primary_for_scope = true
  account_claim_maps = [
    "email=email",
    "name=name",
    "sub=sub"
  ]
  claims_scopes = [
    "email",
    "profile"
  ]
}

resource "boundary_managed_group" "admins" {
  name           = "admins"
  description    = "admins OIDC managed group"
  auth_method_id = boundary_auth_method_oidc.google.id
  filter         = var.admins_group_filter
}

resource "boundary_role" "project_admin" {
  name        = "Project Admin"
  description = "Project Admin role"

  principal_ids = [
    boundary_managed_group.admins.id
  ]

  grant_strings = ["id=*;type=*;actions=*"]

  scope_id       = var.org_scope_id
  grant_scope_id = var.project_scope_id
}

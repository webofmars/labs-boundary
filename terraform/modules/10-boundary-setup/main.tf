resource "boundary_scope" "global" {
  global_scope = true
  scope_id     = "global"
}

resource "boundary_scope" "org" {
  name                     = var.boundary_org_name
  description              = "${var.boundary_org_name} organization"
  scope_id                 = boundary_scope.global.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_scope" "project" {
  for_each               = var.boundary_org_projects
  name                   = each.key
  description            = "${each.key} project"
  scope_id               = boundary_scope.org.id
  auto_create_admin_role = true
}

resource "boundary_auth_method" "password" {
  scope_id    = boundary_scope.global.id
  type        = "password"
  description = "Login and password auth method"
}

resource "boundary_account" "admin" {
  auth_method_id = boundary_auth_method.password.id
  type           = "password"
  login_name     = var.boundary_admin_username
  # password       = var.boundary_admin_password
}

resource "boundary_user" "admin" {
  name        = var.boundary_admin_username
  description = "default admin user"
  account_ids = [boundary_account.admin.id]
  scope_id    = boundary_scope.global.id
}

resource "boundary_role" "global_anon_listing" {
  name        = "global_anon_listing"
  description = "Global Anon Listing"
  scope_id    = boundary_scope.global.id
  principal_ids = [
    "u_anon"
  ]
  grant_strings = [
    "id=*;type=auth-method;actions=list,authenticate",
    "type=scope;actions=list",
    "id={{account.id}};actions=read,change-password",
  ]
}

resource "boundary_role" "org_anon_listing" {
  name        = "org_anon_listing"
  description = "Org Anon Listing"
  scope_id    = boundary_scope.org.id
  principal_ids = [
    "u_anon"
  ]
  grant_strings = [
    "id=*;type=auth-method;actions=list,authenticate",
    "type=scope;actions=list",
    "id={{account.id}};actions=read,change-password",
  ]
}

resource "boundary_role" "global_admin" {
  name           = "global_admin"
  description    = "Global Admin"
  scope_id       = boundary_scope.global.id
  grant_scope_id = boundary_scope.global.id
  principal_ids = [
    boundary_user.admin.id,
    "u_auth"
  ]
  grant_strings = [
    "id=*;type=*;actions=*",
  ]
}

resource "boundary_role" "org_admin" {
  name           = "org_admin"
  description    = "Org Admin"
  scope_id       = boundary_scope.global.id
  grant_scope_id = boundary_scope.org.id
  principal_ids = [
    boundary_user.admin.id,
    "u_auth"
  ]
  grant_strings = [
    "id=*;type=*;actions=*",
  ]
}

# TODO: should we separate global/org/project admins ?
resource "boundary_role" "project_admin" {
  for_each       = var.boundary_org_projects
  name           = "${each.key}_project_admin"
  description    = "${each.key} Project Admin"
  scope_id       = boundary_scope.org.id
  grant_scope_id = boundary_scope.project[each.key].id
  principal_ids = [
    boundary_user.admin.id,
    "u_auth"
  ]
  grant_strings = [
    "id=*;type=*;actions=*",
  ]
}

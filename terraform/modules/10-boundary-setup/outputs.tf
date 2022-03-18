output "projects" {
  value = boundary_scope.project
}

output "default_organization" {
  value = boundary_scope.org
}

output "admin" {
  value = boundary_account.admin
}

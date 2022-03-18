resource "vault_mount" "db" {
  path = "database"
  type = "database"
}

resource "vault_database_secret_backend_connection" "boundary_admin" {
  backend = vault_mount.db.path
  name    = "boundary-admin"

  allowed_roles = ["boundary", "boundary-admin"]

  postgresql {
    connection_url = "postgres://{{username}}:{{password}}@${var.postgres_host}:${var.postgres_port}/${var.postgres_database}"
    username       = var.postgres_admin_username
    password       = var.postgres_admin_password
  }
}

resource "vault_database_secret_backend_static_role" "boundary_admin" {
  backend = vault_mount.db.path
  name    = "boundary-admin"
  db_name = vault_database_secret_backend_connection.boundary_admin.name
  username = "boundary"
  rotation_period = "3600"
  # creation_statements = [
  #   "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
  #   "GRANT ALL PRIVILEGES ON DATABASE boundary TO \"{{name}}\";",
  # ]
  rotation_statements = ["ALTER USER \"{{name}}\" WITH PASSWORD '{{password}}';"]
}

resource "vault_database_secret_backend_role" "boundary" {
  backend = vault_mount.db.path
  name    = "boundary"
  db_name = vault_database_secret_backend_connection.boundary_admin.name
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",
  ]
}

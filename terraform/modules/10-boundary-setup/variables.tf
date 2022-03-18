variable "boundary_org_name" {
  type    = string
  default = "Acme"
}

variable "boundary_org_projects" {
  type    = map
  default =  {
    demo = {}
  }
}

variable "boundary_admin_username" {
  type    = string
  default = "admin"
}

variable "boundary_admin_password" {
  type    = string
  default = "$uper$ecure"
}

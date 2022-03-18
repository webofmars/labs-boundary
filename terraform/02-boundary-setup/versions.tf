terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.8.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.3.1"
    }
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.0.6"
    }
  }
}

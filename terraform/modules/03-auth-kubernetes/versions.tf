terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.3.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.8.0"
    }
  }
}

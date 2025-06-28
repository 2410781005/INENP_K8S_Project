terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.64.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "kubeconfig"
  }
}

provider "exoscale" {
  key    = var.exoscale_key
  secret = var.exoscale_secret
}

locals {
  zone = "at-vie-2"
}

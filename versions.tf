terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.64.0"
    }
  }
}

provider "exoscale" {
  key    = var.exoscale_key
  secret = var.exoscale_secret
}

locals {
  zone = "at-vie-2"
}

terraform {
  required_version = ">= 1.2.8"
  required_providers {
    esxi = {
      source  = "registry.terraform.io/josenk/esxi"
      version = ">= 1.10.2"
    }
  }
}
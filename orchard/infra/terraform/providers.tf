terraform {
  required_version = ">= 1.2.8"
  required_providers {
    esxi = {
      source  = "registry.terraform.io/josenk/esxi"
      version = ">= 1.10.2"
    }
  }
}

provider "esxi" {
  alias         = "esx_mac_01"
  esxi_hostname = "192.168.1.76"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_mac_05"
  esxi_hostname = "192.168.1.107"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_mac_06"
  esxi_hostname = "192.168.1.72"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

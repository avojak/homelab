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
  alias         = "esx_asus_01"
  esxi_hostname = "192.168.1.112"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_mac_01"
  esxi_hostname = "192.168.1.52"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_mac_02"
  esxi_hostname = "192.168.1.64"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_mac_03"
  esxi_hostname = "192.168.1.120"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_mac_04"
  esxi_hostname = "192.168.1.79"
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}
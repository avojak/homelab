terraform {
  required_version = ">= 1.2.8"
  required_providers {
    esxi = {
      source  = "registry.terraform.io/josenk/esxi"
      version = ">= 1.10.2"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "~> 1.3.0"
    }
  }
}

locals {
  esxi_hosts = {
    esx_rpi_01 = {
      hostname   = "esx-rpi-01.${var.root_domain}"
      ip_address = "192.168.1.161"
    }
    esx_rpi_02 = {
      hostname   = "esx-rpi-02.${var.root_domain}"
      ip_address = "192.168.1.230"
    }
    esx_rpi_03 = {
      hostname   = "esx-rpi-03.${var.root_domain}"
      ip_address = "192.168.1.22"
    }
  }
}

provider "esxi" {
  alias         = "esx_rpi_01"
  esxi_hostname = local.esxi_hosts.esx_rpi_01.ip_address
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_rpi_02"
  esxi_hostname = local.esxi_hosts.esx_rpi_02.ip_address
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

provider "esxi" {
  alias         = "esx_rpi_03"
  esxi_hostname = local.esxi_hosts.esx_rpi_03.ip_address
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

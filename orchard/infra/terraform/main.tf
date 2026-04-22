module "primary" {
  source = "./modules/node"
  providers = {
    esxi = esxi.esx_mac_06
  }
  ova_file        = var.ova_file
  guest_name      = "primary"
  hostname        = "primary.orchard.vojak.cloud"
  ssh_public_key  = var.ssh_public_key
  numvcpus        = 4
  install_kubectl = true
}

module "worker_1" {
  source = "./modules/node"
  providers = {
    esxi = esxi.esx_mac_01
  }
  ova_file       = var.ova_file
  guest_name     = "worker-1"
  hostname       = "worker-1.orchard.vojak.cloud"
  ssh_public_key = var.ssh_public_key
}

module "worker_2" {
  source = "./modules/node"
  providers = {
    esxi = esxi.esx_mac_05
  }
  ova_file       = var.ova_file
  guest_name     = "worker-2"
  hostname       = "worker-2.orchard.vojak.cloud"
  ssh_public_key = var.ssh_public_key
}
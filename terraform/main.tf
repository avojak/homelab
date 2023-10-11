module "pihole01" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_mac_03
  }
  guest_name     = "pihole01"
  boot_disk_size = 25
  memsize        = 4
  numvcpus       = 2
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}

module "pihole02" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_mac_03
  }
  guest_name     = "pihole02"
  boot_disk_size = 25
  memsize        = 4
  numvcpus       = 2
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}

module "routing" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_mac_03
  }
  guest_name     = "routing"
  boot_disk_size = 25
  memsize        = 8
  numvcpus       = 4
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}

module "plex" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_asus_01
  }
  guest_name     = "plex"
  boot_disk_size = 200
  memsize        = 30
  numvcpus       = 6
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}

module "plausible" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_mac_02
  }
  guest_name     = "plausible"
  boot_disk_size = 250
  memsize        = 8
  numvcpus       = 4
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}

module "homebridge" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_mac_02
  }
  guest_name     = "homebridge"
  boot_disk_size = 50
  memsize        = 8
  numvcpus       = 4
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}

module "monitoring" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_mac_04
  }
  guest_name     = "monitoring"
  boot_disk_size = 300
  memsize        = 16
  numvcpus       = 8
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}

module "minecraft" {
  source = "./modules/appserver"
  providers = {
    esxi = esxi.esx_mac_05
  }
  guest_name     = "minecraft"
  boot_disk_size = 100
  memsize        = 16
  numvcpus       = 8
  ova_file       = var.ova_files["ubuntu"]["amd64"]
}
resource "esxi_guest" "appserver" {
  guest_name = var.guest_name
  disk_store = "datastore1"

  network_interfaces {
    virtual_network = "VM Network"
    nic_type        = "vmxnet3"
  }

  guest_startup_timeout  = 45 # Seconds
  guest_shutdown_timeout = 30 # Seconds

  boot_firmware  = "bios"
  boot_disk_size = var.boot_disk_size
  memsize        = var.memsize * 1024
  numvcpus       = var.numvcpus
  power          = "on"

  ovf_source = var.ova_file
}
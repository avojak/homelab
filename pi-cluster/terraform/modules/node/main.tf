resource "esxi_guest" "appserver" {
  guest_name = var.guest_name
  disk_store = "datastore1"

  network_interfaces {
    virtual_network = "VM Network"
    nic_type        = "vmxnet3"
  }

  guest_startup_timeout  = 45 # Seconds
  guest_shutdown_timeout = 30 # Seconds

  boot_firmware  = "efi"
  boot_disk_size = var.boot_disk_size
  memsize        = var.memsize * 1024
  numvcpus       = var.numvcpus
  power          = "on"

  ovf_source = var.ova_file

  # guestinfo = {
  #   "userdata"          = base64gzip(templatefile("${path.module}/cloud-config.tftpl", {

  #   }))
  #   "userdata.encoding" = "gzip+base64"
  # }
}

resource "ansible_host" "appserver" {
  name   = var.guest_name
  groups = [var.inventory_group, "guests"]

  variables = {
    ansible_user = "provisioner"
    ansible_host = esxi_guest.appserver.ip_address
  }
}

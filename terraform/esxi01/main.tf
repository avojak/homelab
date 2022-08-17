#########################################
#  ESXI Provider host/login details
#########################################

provider "esxi" {
    esxi_hostname = var.esxi_hostname
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

#########################################
#  ESXI Guest resources
#########################################

resource "esxi_guest" "coruscant" {
    guest_name = "coruscant"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    boot_disk_size = 100
    memsize = 14336 # 14 GB
    numvcpus = 4
    power = "on"

    ovf_source = var.ovf_file
}
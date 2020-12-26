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

# Homebridge
resource "esxi_guest" "ubuntusrv01" {
    guest_name = "ubuntusrv01"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    boot_disk_size = 100
    memsize = 8192
    numvcpus = 4
    power = "on"

    ovf_source = var.ovf_file
}

# Pi-hole 1
resource "esxi_guest" "pihole01" {
    guest_name = "pihole01"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    boot_disk_size = 8
    memsize = 1024
    numvcpus = 1
    power = "on"

    ovf_source = var.ovf_file
}

# Pi-hole 2
resource "esxi_guest" "pihole02" {
    guest_name = "pihole02"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    boot_disk_size = 8
    memsize = 1024
    numvcpus = 1
    power = "on"

    ovf_source = var.ovf_file
}
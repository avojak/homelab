#########################################
#  ESXI Provider host/login details
#########################################

provider "esxi" {
    alias = "esx-mac-01"
    esxi_hostname = var.esxi_hostname["esx-mac-01"]
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

# provider "esxi" {
#     alias = "esx-mac-02"
#     esxi_hostname = var.esxi_hostname["esx-mac-02"]
#     esxi_hostport = var.esxi_hostport
#     esxi_username = var.esxi_username
#     esxi_password = var.esxi_password
# }

provider "esxi" {
    alias = "esx-rpi-01"
    esxi_hostname = var.esxi_hostname["esx-rpi-01"]
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

provider "esxi" {
    alias = "esx-rpi-02"
    esxi_hostname = var.esxi_hostname["esx-rpi-02"]
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

#########################################
#  ESXI Guest resources
#########################################

resource "esxi_guest" "pihole-01" {
    provider = esxi.esx-rpi-02
    guest_name = "pihole-01"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    # boot_disk_size = 50 # GB
    memsize = 2048 # 2 GB
    numvcpus = 2
    power = "on"
    boot_firmware = "efi"

    ovf_source = var.ova_file["arm64"]
}

resource "esxi_guest" "pihole-02" {
    provider = esxi.esx-rpi-02
    guest_name = "pihole-02"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    # boot_disk_size = 50 # GB
    memsize = 2048 # 2 GB
    numvcpus = 2
    power = "on"
    boot_firmware = "efi"

    ovf_source = var.ova_file["arm64"]
}

# resource "esxi_guest" "coruscant" {
#     provider = esxi.esx-mac-01
#     guest_name = "coruscant"
#     disk_store = var.disk_store

#     network_interfaces {
#         virtual_network = var.virtual_network
#         nic_type = var.nic_type
#     }

#     guest_startup_timeout = var.guest_startup_timeout
#     guest_shutdown_timeout = var.guest_shutdown_timeout

#     boot_disk_size = 100 # GB
#     memsize = 14336 # 14 GB
#     numvcpus = 4
#     power = "on"

#     ovf_source = var.ova_file["amd64"]
# }
#########################################
#  ESXI Provider host/login details
#########################################

provider "esxi" {
    alias = "esx-luna-01"
    esxi_hostname = var.esxi_hostname["esx-luna-01"]
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

provider "esxi" {
    alias = "esx-mac-01"
    esxi_hostname = var.esxi_hostname["esx-mac-01"]
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

provider "esxi" {
    alias = "esx-mac-02"
    esxi_hostname = var.esxi_hostname["esx-mac-02"]
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

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

provider "esxi" {
    alias = "esx-lvo-01"
    esxi_hostname = var.esxi_hostname["esx-lvo-01"]
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

resource "esxi_guest" "homelab-prx" {
    provider = esxi.esx-rpi-01
    guest_name = "homelab-prx"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    # boot_disk_size = 50 # GB
    memsize = 6144 # 6 GB
    numvcpus = 4
    power = "on"
    boot_firmware = "efi"

    ovf_source = var.ova_file["arm64"]
}

resource "esxi_guest" "homelab-app-01" {
    provider = esxi.esx-mac-01
    guest_name = "homelab-app-01"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    boot_disk_size = 100 # GB
    memsize = 14336 # 14 GB
    numvcpus = 4
    power = "on"

    ovf_source = var.ova_file["amd64"]
}

resource "esxi_guest" "homelab-mon" {
    provider = esxi.esx-mac-02
    guest_name = "homelab-mon"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    boot_disk_size = 100 # GB
    memsize = 14336 # 14 GB
    numvcpus = 4
    power = "on"

    ovf_source = var.ova_file["amd64"]
}

resource "esxi_guest" "homelab-plex" {
    provider = esxi.esx-luna-01
    guest_name = "homelab-plex"
    disk_store = var.disk_store

    network_interfaces {
        virtual_network = var.virtual_network
        nic_type = var.nic_type
    }

    guest_startup_timeout = var.guest_startup_timeout
    guest_shutdown_timeout = var.guest_shutdown_timeout

    boot_disk_size = 200 # GB
    memsize = 30720 # 30 GB
    numvcpus = 6
    power = "on"

    ovf_source = var.ova_file["amd64"]
}
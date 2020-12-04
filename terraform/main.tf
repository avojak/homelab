#########################################
#  ESXI Provider host/login details
#########################################

provider "esxi" {
    esxi_hostname = var.esxi_hostname
    esxi_hostport = var.esxi_hostport
    esxi_username = var.esxi_username
    esxi_password = var.esxi_password
}

# data "template_file" "userdata_default" {
#     template = file("userdata.tpl")
#     # vars = {
#     #     HOSTNAME = var.vm_hostname
#     #     HELLO    = "Hello EXSI World!"
#     # }
# }

# data "template_file" "metadata_default" {
#     template = file("metadata.tpl")
# }

#########################################
#  ESXI Guest resource
#########################################

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

    # ovf_source = "/Users/avojak/Downloads/centos8-1.vmdk"
    ovf_source = var.ovf_file
    # clone_from_vm = "_TEMPLATE_centos8"

    # guestinfo = {
    #     "userdata.encoding" = "gzip+base64"
    #     "userdata" = base64gzip(data.template_file.userdata_default.rendered)
    #     "metadata.encoding" = "gzip+base64"
    #     "metadata" = base64gzip(data.template_file.metadata_default.rendered)
    # }

    # ovf_properties {
    #     key = "password"
    #     value = "Passw0rd1"
    # }

    # ovf_properties {
    #     key = "hostname"
    #     value = "ubuntusrv01"
    # }

    # ovf_properties {
    #     key = "user-data"
    #     value = base64encode(data.template_file.userdata_default.rendered)
    # }
}
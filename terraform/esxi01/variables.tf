#########################################
#  ESXI Host Variables
#########################################

variable "esxi_hostname" {
    default = "192.168.1.64"
}

variable "esxi_hostport" {
    default = 22
}

variable "esxi_username" {
    default = "root"
}

variable "esxi_password" {
    # Unspecified will prompt
}

#########################################
#  ESXI VM Guest Variables
#########################################

variable "disk_store" {
    default = "datastore1"
}

variable "virtual_network" {
    default = "VM Network"
}

variable "nic_type" {
    default = "vmxnet3"
}

variable "guest_startup_timeout" {
    default = 45
}

variable "guest_shutdown_timeout" {
    default = 30
}

variable "ovf_file" {
    default = "../../packer/output/ubuntu-20.04-server/packer-ubuntu-20.04-server.ova"
}
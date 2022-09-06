#########################################
#  ESXI Host Variables
#########################################

variable "esxi_hostname" {
    type = map
    description = "The map of hostnames/IPs of the ESXi hosts by provider alias"
}

variable "esxi_hostport" {
    type = number
    description = "The SSH port on the ESXi host"
    default = 22
}

variable "esxi_username" {
    type = string
    description = "The SSH user for the ESXi host"
    default = "root" # Default user created when installing ESXi, and has SSH access
}

variable "esxi_password" {
    type = string
    description = "The SSH password for the ESXi hosts"
    sensitive = true
}

#########################################
#  VM Guest Variables
#########################################

variable "disk_store" {
    type = string
    description = "The name of the disk store on the ESXi host that will be used to store the VM guest"
    default = "datastore1" # Default datastore created when installing ESXi
}

variable "virtual_network" {
    type = string
    description = "The name of the virtual network on the ESxi host that will be assigned to the VM guest"
    default = "VM Network" # Default virtual network created when installing ESXi
}

variable "nic_type" {
    type = string
    description = "The NIC type that will be used for the VM guest"
    default = "vmxnet3"
}

variable "guest_startup_timeout" {
    type = number
    description = "The duration (in seconds) to wait for the guest to startup"
    default = 45
}

variable "guest_shutdown_timeout" {
    type = number
    description = "The duration (in seconds) to wait for the guest to shutdown"
    default = 30
}

variable "ova_file" {
    type = map
    description = "The map of OVA templates by system architecture"
}
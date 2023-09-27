#########################################
#  VM Guest Variables
#########################################

variable "guest_name" {
  type        = string
  description = "The name of the VM displayed in the ESXi management console"
}

variable "boot_disk_size" {
  type        = number
  description = "The size of the boot disk in GB"
  default     = 100
}

variable "memsize" {
  type        = number
  description = "The memory size in GB"
  default     = 4
}

variable "numvcpus" {
  type        = number
  description = "The number of vCPUs"
  default     = 2
}

variable "ova_file" {
  type        = string
  description = "The OVA template to use to create the VM"
}
#########################################
#  ESXI Host Variables
#########################################

variable "esxi_hostport" {
  type        = number
  description = "The SSH port on the ESXi host"
  default     = 22
}

variable "esxi_username" {
  type        = string
  description = "The SSH user for the ESXi host"
  default     = "root" # Default user created when installing ESXi, and has SSH access
}

variable "esxi_password" {
  type        = string
  description = "The SSH password for the ESXi hosts"
  sensitive   = true
}

#########################################
#  VM Guest Variables
#########################################

variable "ova_files" {
  type        = map(map(string))
  description = "The map of architectures to OVA files"
  default = {
    "ubuntu" = {
      "amd64" = "../packer/output/ubuntu-22.04-server-amd64.ova"
      "arm64" = "../packer/output/ubuntu-22.04-server-arm64.ova"
    }
  }
}
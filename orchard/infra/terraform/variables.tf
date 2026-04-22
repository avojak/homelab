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

variable "ova_file" {
  type        = string
  description = "The file path to the OVA file"
}

variable "ssh_public_key" {
  type        = string
  description = "The public SSH key"
}
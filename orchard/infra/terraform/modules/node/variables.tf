#########################################
#  VM Guest Variables
#########################################

variable "guest_name" {
  type        = string
  description = "The name of the VM displayed in the ESXi management console"
}

variable "hostname" {
  type        = string
  description = "The VM hostname"
}

variable "boot_disk_size" {
  type        = number
  description = "The size of the boot disk in GB"
  default     = 100
}

variable "memsize" {
  type        = number
  description = "The memory size in GB"
  default     = 16
}

variable "numvcpus" {
  type        = number
  description = "The number of vCPUs"
  default     = 8
}

variable "ova_file" {
  type        = string
  description = "The OVA template to use to create the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "The public SSH key"
}

variable "fedora_version" {
  type        = string
  description = "The Fedora CoreOS version"
  default     = "39"
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version"
  default     = "1.29"
}

variable "cni_version" {
  type        = string
  description = "The CNI plugins version"
  default     = "v1.4.0"
}

variable "crictl_version" {
  type        = string
  description = "The CNI plugins version"
  default     = "v1.29.0"
}

variable "install_kubectl" {
  type        = bool
  description = "Whether or not to install kubectl"
  default     = false
}
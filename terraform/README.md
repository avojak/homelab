# Terraform

This section leverages Terraform to deploy VMs to ESXi using the `.ova` file built previously by Packer.

Each ESXi host should have its own sub-directory here.

You will need to update the `variables.tf` file to point to the IP/hostname of your ESXi host(s), and appropriately determine the specs for each VM.
# homelab

This repository contains the configuration-as-code for my homelab.

## Prerequisites

### 1. ESXi Host

* SSH access must be enabled temporarily on the ESXi host when running Terraform.
* By default, Terraform expects a virtual network named "VM Network"
* By default, Terraform expects a disk store named "DS_001"
* By default, Terraform expects a user "root" and access on port 22

### 2. Base VM Template

The base VM template is a clean install of CentOS with a single non-root user (ansible_user) for use during configuration.

I followed this guide to create a VM template: https://techexpert.tips/vmware/create-windows-virtual-machine-template-on-vmware-esxi/

### 3. SSH Key for Ansible

An SSH key-pair for Ansible should be created:

```bash
$ ssh-keygen -t rsa -b 4096 -f ./id_rsa -C "" -N ""
```

### Terraform ESXi Provider

To use Terraform with ESXi without vCenter (because $$$), I used [terraform-provider-esxi](https://github.com/josenk/terraform-provider-esxi).

The terraform-provider-esxi executable should be placed in the `terraform/` directory.

## Usage

### Packer

```bash
$ cd packer
$ packer build ubuntu-18.04-server-packer.json
```

### Terraform

Terraform is used to stand up the VM hosts on ESXi.

```bash
$ cd terraform/
$ terraform init
$ terraform plan
$ terraform apply
```

To view the deployment:

```bash
$ terraform show
```

If needed, you can destroy the VMs created with Terraform by using:

```bash
$ terraform destroy
```

### Ansible

Ansible is used to configure the VM hosts.
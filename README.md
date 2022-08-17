# homelab

This repository contains the configuration-as-code for my homelab.

## Prerequisites

### 1. ESXi Host

* SSH access must be enabled temporarily on the ESXi host when running Terraform. **(Don't forget to disable this when you're done!)**
* By default, Terraform expects a virtual network named "VM Network" *(Created by default when ESXi is installed)*
* By default, Terraform expects a disk store named "datastore1" *(Created by default when ESXi is installed)*
* By default, Terraform expects an ESXi user "root" and access on port 22 *(Created by default when ESXi is installed)*

### 2. Terraform ESXi Provider

To use Terraform with ESXi without vCenter (because $$$), I used [terraform-provider-esxi](https://github.com/josenk/terraform-provider-esxi).

The terraform-provider-esxi executable should be placed in the `terraform/` directory.

## Usage

### Initialize Prerequisites

This will initialize Terraform, and generate an SSH key for Ansible to use.

```bash
$ make init
```

### Packer

Packer is used to build the base VM image.

```bash
$ make image
```

This is a good time to make a cup of coffee - it'll take a while.

The output `.ova` image will be placed in `./packer/output/`.

### Terraform

Terraform is used to stand up the VM hosts on ESXi.

```bash
$ make plan-deploy
$ make deploy
```

If needed, you can destroy the VMs created with Terraform by using:

```bash
$ make undeploy
```

### Ansible

Ansible is used to configure the VM hosts.

```bash
$ make install
```

In following with Ansible principles, this command can be run repeatedly to ensure constant state and apply any updates.

----

## References

- I followed this guide to create a VM template: https://techexpert.tips/vmware/create-windows-virtual-machine-template-on-vmware-esxi/
- And this repository for help moving from Ubuntu 18.04 to 20.04: https://github.com/rodm/packer-templates
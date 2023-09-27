# homelab

This repository contains the configuration-as-code for my homelab.

The goal is to automate as much as possible to a reasonable extent. This means that there will be manual intervention involved, such as plugging in IP addresses after VMs are provisioned, and some application configuration after installation.

## Prerequisites

### 1. VMware Workstation

For the Packer builds to work you will need VMware Workstation (or Fusion if you're on macOS) to be installed.

### 2. ESXi Hosts

* SSH access must be enabled temporarily on the ESXi host when running Terraform. **(Don't forget to disable this when you're done!)**
* By default, Terraform expects a virtual network named "VM Network" *(Created by default when ESXi is installed)*
* By default, Terraform expects a disk store named "datastore1" *(Created by default when ESXi is installed)*
* By default, Terraform expects an ESXi user "root" and access on port 22 *(Created by default when ESXi is installed)*

For all hosts it's a good idea to configure ntpd to start/stop with the host, and set a network time server (e.g. `time.nist.gov`).

#### ARM Hosts

For the Raspberry Pi ESXi host(s) that you will be using to build the OVA templates you will need to enable GuestIPHack on the host:

```
esxcli system settings advanced set -o /Net/GuestIPHack -i 1
```

### 3. Terraform ESXi Provider

To use Terraform with ESXi without vCenter (because $$$), I used [terraform-provider-esxi](https://github.com/josenk/terraform-provider-esxi).

The terraform-provider-esxi executable should be placed in the `terraform/` directory.

## Usage

### Initialize Prerequisites

This will initialize Terraform, fetch the providers listed in `terraform/versions.tf`, and generate an SSH key for Ansible to use.

```bash
$ make init
```

### Packer

Packer is used to build the base VM images.

```bash
$ make image
```

This is a good time to make a cup of coffee - it'll take a while.

The output `.ova` images will be placed in `./packer/output/`.

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

## Landscape

| Physical Host | Model | Specs | OS | Alias |
| ------------- | ----- | ----- | -- | ----- |
| Mac mini | Late 2012 (6,2) | Quad-core i7-3720QM @ 2.6GHz, 16 GB RAM | ESXi 7.0 | `esx-mac-01` |
| Mac mini | Late 2012 (6,2) | Quad-core i7-3720QM @ 2.6GHz, 16 GB RAM | ESXi 7.0 | `esx-mac-02` |
| Luna Design | DNK-H | Hexa-core i5-9400 @ 2.9 GHz, 32 GB RAM| ESXi 6.7.0* | `esx-luna-01` |
| Raspberry Pi | Model 4B | Quad-core ARM Cortex-A72, 8 GB RAM | ESXi 7.0 |  `esx-rpi-01` |
| Raspberry Pi | Model 4B | Quad-core ARM Cortex-A72, 4 GB RAM | ESXi 7.0 |  `esx-rpi-02` |
<!-- | Lenovo | W540 | Quad-core i7-4800MQ @ 2.7GHz, 16 GB RAM | ESXi 6.7.0 U3 | `esx-lvo-01` | -->

_\* Patched with RTL8111 driver (See: [Installing ESXi for Realtek 8111 NIC](https://avojak.com/blog/2020/12/19/installing-esxi-for-realtek-8111-nic/))_


| Physical Host Alias (IP) | Virtual Host (IP) | Guest OS | Software |
| ----------------------- | ----------------- | -- | -------- |
| `esx-mac-01` (192.168.1.52) | `homelab-app-01` (192.168.1.202) | [Ubuntu Server 22.04 (amd64)](./packer/ubuntu-22.04-server-amd64/) | Homebridge (`:8581`)<br>Scrypted (`:10443`)<br>Plausible (`:8000`)<br>Jellyfin (`:8096`)<br> |
| `esx-mac-02` (192.168.1.64) | `homelab-mon` (192.168.1.114) | [Ubuntu Server 22.04 (amd64)](./packer/ubuntu-22.04-server-amd64/) | InfluxDB (`:8086`)<br>Grafana (`:3000`)<br>Uptime Kuma (`:3001`)<br>Portainer (`:9000`, `:9443`) |
| `esx-luna-01` (192.168.1.41) | `homelab-plex` (192.168.1.130) | [Ubuntu Server 22.04 (amd64)](./packer/ubuntu-22.04-server-amd64/) | Plex (`:32400`) |
| `esx-rpi-01` (192.168.1.230) | `homelab-prx` (192.168.1.150) | [Ubuntu Server 22.04 (arm64)](./packer/ubuntu-22.04-server-arm64/) | Traefik (`:80`, `:443`, `:8081`)<br>Cloudflare DDNS<br>Heimdall (`:8080`, `:8443`) |
| `esx-rpi-02` (192.168.1.22) | `pihole-01` (192.168.1.153) | [Ubuntu Server 22.04 (arm64)](./packer/ubuntu-22.04-server-arm64/) | Pi-hole (`:53`, `:80`) |
|  | `pihole-02` (192.168.1.131) | [Ubuntu Server 22.04 (arm64)](./packer/ubuntu-22.04-server-arm64/) | Pi-hole (`:53`, `:80`) |
<!-- | `esx-lvo-01` (192.168.1.112) | `homelab-app-01` (192.168.1.220) | [Ubuntu Server 22.04 (amd64)](./packer/ubuntu-22.04-server-amd64/) |  | -->

<!-- ## Pi-hole Hosts

The Pi-holes are hosted on older Raspberry Pi models (3B Rev 1.2 and 2B Rev 1.1), so the host OS is configured manually vs. running ESXi.

After installation, each host was manually configured as follows:
1. Login to the host and create the `provisioner` user account
    - `sudo adduser provisioner`
    - `sudo usermod -aG sudo provisioner`
2. Add passwordless sudo (`sudo visudo`), at the end add `provisioner ALL=(ALL) NOPASSWD: ALL`
3. Run `sudo raspi-config`, and enable SSH and I2C under Interface Options
4. Reboot
5. The SSH key for the `provisioner` user account was copied with `ssh-copy-id -i id_rsa provisioner@192.168.1.xxx` -->

----

## References

- I followed this guide to create a VM template: https://techexpert.tips/vmware/create-windows-virtual-machine-template-on-vmware-esxi/
- And this repository for help moving from Ubuntu 18.04 to 20.04: https://github.com/rodm/packer-templates
- https://williamlam.com/2020/10/packer-reference-for-photonos-arm-nfs-virtual-appliance-using-ovf-properties-for-esxi-arm.html
- https://github.com/lamw/photonos-arm-nfs-appliance/blob/master/photon.json
- https://www.packer.io/plugins/builders/vmware/iso#building-on-a-remote-vsphere-hypervisor
- https://communities.vmware.com/t5/Open-Virtualization-Format-Tool/Failed-to-deploy-OVA/td-p/1329381
- https://virtualizationreview.com/articles/2020/10/27/esxi-on-arm.aspx

----

Issues & TODOs:

[ ] Setup a different datastore for the Pi host that's building the templates so we don't take up disk space from VMs
[ ] Unable to resize the boot volume for the arm64 templates
[ ] Auto resize root volume: https://askubuntu.com/a/937351/919056
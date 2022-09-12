# Ansible

This section installs the software on the VMs using Ansible.

To create an ecrypted secret that can safely be checked-in to version control, use the following command:

```bash
$ ansible-vault encrypt_string --vault-password-file .vault-password-file <string>
```

## Prerequisites

1. The NAS containing Plex media needs to allow the VM to mount it

## Installed Software

| Name | UI Port/Path |
| ---- | ------------ |
| Homebridge | `:8581` |
| Plex | `:32400/web/index.html` |

## Software

### Pi-hole

#### Variables

| Name | Type | Default | Description |
| ---- | ---- | ------- | ----------- |
| `pihole_upstream_dns` | `list(string)` | `"208.67.222.222"` (OpenDNS)<br>`"208.67.220.220"` (OpenDNS)<br>`"1.1.1.1"` (Cloudflare)<br>`"1.0.0.1"` (Cloudflare)| The upstream DNS servers to use when resolving non-blocked domains |
| `pihole_web_password` | `string` | `"P@$$w0rd"` | The password for logging into the web dashboard | 
| `pihole_timezone` | `string` | `"America/Chicago"` | The timezone |
| `pihole_temp_unit` | `string` | `"pihole_temp_unit"` | The temperature unit when displaying host CPU temperature in the dashboard |
| `pihole_dnsmasq` | `string` | `"pihole_dnsmasq"` | |
| `pihole_adlists` | `list(dict)` | `[{address: "", enabled: yes, comment: ""}]` | |
| `pihole_domainlist` | `list(dict)` | `[{domain: "", type: 0, enabled: yes, comment: ""}]` | |
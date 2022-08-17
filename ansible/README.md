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
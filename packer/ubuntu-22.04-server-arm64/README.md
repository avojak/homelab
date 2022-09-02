<!-- https://github.com/mkaczanowski/packer-builder-arm -->

https://williamlam.com/2020/10/packer-reference-for-photonos-arm-nfs-virtual-appliance-using-ovf-properties-for-esxi-arm.html
https://github.com/lamw/photonos-arm-nfs-appliance/blob/master/photon.json
https://www.packer.io/plugins/builders/vmware/iso#building-on-a-remote-vsphere-hypervisor

Requires GuestIPHack on ESX host:
```
esxcli system settings advanced set -o /Net/GuestIPHack -i 1
```

It might look like subiquity is stuck at multiple points but it's not, it just takes a while (especially if building on a Pi, it can take upwards of an hour).
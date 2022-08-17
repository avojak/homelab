# Packer

This section leverages Packer to build the base VM image as a `.ova` file.

It will pull the Ubuntu Server 20.04 server ISO and then:
1. Run through the installation
2. Create a `provisioner` user that will be used later to install software
3. Install updates
4. Dump the `.ova` file in the `output/` directory
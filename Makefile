MAKE_DIR = $(PWD)

PACKER_DIR    := $(MAKE_DIR)/packer
TERRAFORM_DIR := $(MAKE_DIR)/terraform 
ANSIBLE_DIR   := $(MAKE_DIR)/ansible

PACKER_MAKEFILE    := packer.mk
TERRAFORM_MAKEFILE := terraform.mk
ANSIBLE_MAKEFILE   := ansible.mk

sshkey:
	ssh-keygen -t rsa -b 4096 -f ./id_rsa -C "" -N ""
build:
	@$(MAKE) -C $(PACKER_DIR) -f $(PACKER_MAKEFILE) ova
deploy:
	@$(MAKE) -C $(TERRAFORM_DIR) -f $(TERRAFORM_MAKEFILE) deploy

.PHONY: clean
clean:
	@$(MAKE) -C $(PACKER_DIR) -f $(PACKER_MAKEFILE) $@

.PHONY: lint
lint:
	@$(MAKE) -C $(PACKER_DIR) -f $(PACKER_MAKEFILE) $@
	@$(MAKE) -C $(TERRAFORM_DIR) -f $(TERRAFORM_MAKEFILE) $@
MAKE_DIR = $(PWD)

PACKER_DIR    := $(MAKE_DIR)/packer
TERRAFORM_DIR := $(MAKE_DIR)/terraform 
ANSIBLE_DIR   := $(MAKE_DIR)/ansible

PACKER_MAKEFILE    := packer.mk
TERRAFORM_MAKEFILE := terraform.mk
ANSIBLE_MAKEFILE   := ansible.mk

all: lint init image deploy

SSH_KEY_FILE := id_rsa

$(SSH_KEY_FILE):
	ssh-keygen -t rsa -b 4096 -f $@ -C "" -N ""

init: $(SSH_KEY_FILE)
	@$(MAKE) -C $(TERRAFORM_DIR) -f $(TERRAFORM_MAKEFILE) $@
image:
	@$(MAKE) -C $(PACKER_DIR) -f $(PACKER_MAKEFILE) ova
plan-deploy:
	@$(MAKE) -C $(TERRAFORM_DIR) -f $(TERRAFORM_MAKEFILE) plan
deploy:
	@$(MAKE) -C $(TERRAFORM_DIR) -f $(TERRAFORM_MAKEFILE) apply
undeploy:
	@$(MAKE) -C $(TERRAFORM_DIR) -f $(TERRAFORM_MAKEFILE) destroy
install:
	@$(MAKE) -C $(ANSIBLE_DIR) -f $(ANSIBLE_MAKEFILE) run
clean:
	@$(MAKE) -C $(PACKER_DIR) -f $(PACKER_MAKEFILE) $@
lint:
	@$(MAKE) -C $(PACKER_DIR) -f $(PACKER_MAKEFILE) $@
	@$(MAKE) -C $(TERRAFORM_DIR) -f $(TERRAFORM_MAKEFILE) $@
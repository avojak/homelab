MAKE_DIR = $(PWD)

PACKER_DIR    := $(MAKE_DIR)/packer
TERRAFORM_DIR := $(MAKE_DIR)/terraform 
ANSIBLE_DIR   := $(MAKE_DIR)/ansible

all: lint init image deploy

SSH_KEY_FILE := id_rsa

$(SSH_KEY_FILE):
	ssh-keygen -t rsa -b 4096 -f $@ -C "" -N ""

.PHONY: init
init: $(SSH_KEY_FILE)
	@$(MAKE) -C $(TERRAFORM_DIR) $@
	@$(MAKE) -C $(ANSIBLE_DIR) $@

.PHONY: image
image:
	@$(MAKE) -C $(PACKER_DIR) ova

.PHONY: plan-deploy
plan-deploy:
	@$(MAKE) -C $(TERRAFORM_DIR) plan

.PHONY: deploy
deploy:
	@$(MAKE) -C $(TERRAFORM_DIR) apply

.PHONY: undeploy
undeploy:
	@$(MAKE) -C $(TERRAFORM_DIR) destroy

.PHONY: install
install:
	@$(MAKE) -C $(ANSIBLE_DIR) install

.PHONY: clean
clean:
	@$(MAKE) -C $(PACKER_DIR) $@

.PHONY: lint
lint:
	@$(MAKE) -C $(PACKER_DIR) $@
	@$(MAKE) -C $(TERRAFORM_DIR) $@

runner:
	docker build -t avojak/homelab-runner .
IMAGE_NAME := ubuntu-20.04-server

SSH_KEY := $(shell cat ../id_rsa.pub)

OUTPUT_DIR    := output
OVA_FILE      := $(OUTPUT_DIR)/$(IMAGE_NAME)/packer-$(IMAGE_NAME).ova
TEMPLATE_FILE := $(IMAGE_NAME)-template.json

.DEFAULT_GOAL := ova

$(OVA_FILE):
	packer build -var 'ssh_key=$(SSH_KEY)' -var 'vm_name=$(IMAGE_NAME)' $(TEMPLATE_FILE)

ova: $(OVA_FILE)

.PHONY: clean
clean:
	@$(RM) -rf ./$(OUTPUT_DIR)/$(IMAGE_NAME)/

.PHONY: lint
lint:
	packer validate $(TEMPLATE_FILE)
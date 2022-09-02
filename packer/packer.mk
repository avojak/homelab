BASE_IMAGE_NAME  := ubuntu-22.04-server
AMD64_IMAGE_NAME := $(BASE_IMAGE_NAME)-amd64
ARM64_IMAGE_NAME := $(BASE_IMAGE_NAME)-arm64

OUTPUT_DIR := output

AMD64_OVA_FILE := $(OUTPUT_DIR)/$(AMD64_IMAGE_NAME).ova
AMD64_TEMPLATE_FILE := $(AMD64_IMAGE_NAME)/template.json

ARM64_OVA_FILE := $(OUTPUT_DIR)/$(ARM64_IMAGE_NAME).ova
ARM64_TEMPLATE_FILE := $(ARM64_IMAGE_NAME)/template.json

SSH_KEY            := $(shell cat ../id_rsa.pub)
ESXI_ROOT_PASSWORD := $(shell cat ../.esxi_root_password)

.DEFAULT_GOAL := ova

$(AMD64_OVA_FILE):
	packer build -var 'ssh_key=$(SSH_KEY)' -var 'vm_name=$(AMD64_IMAGE_NAME)' $(AMD64_TEMPLATE_FILE)
#	PACKER_LOG=1 packer build -var 'ssh_key=$(SSH_KEY)' -var 'vm_name=$(AMD64_IMAGE_NAME)' $(AMD64_TEMPLATE_FILE)

$(ARM64_OVA_FILE):
	packer build \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(ARM64_IMAGE_NAME)' \
		-var 'builder_host_password=$(ESXI_ROOT_PASSWORD)' \
		$(ARM64_TEMPLATE_FILE)
# 	packer build -var 'ssh_key=$(SSH_KEY)' -var 'vm_name=$(ARM64_IMAGE_NAME)' $(ARM64_TEMPLATE_FILE)

ova: $(AMD64_OVA_FILE) $(ARM64_OVA_FILE)

.PHONY: clean
clean:
	@$(RM) -rf $(AMD64_IMAGE_NAME) $(ARM64_IMAGE_NAME)

.PHONY: lint
lint:
	packer validate $(AMD64_TEMPLATE_FILE)
	packer validate $(ARM64_TEMPLATE_FILE)
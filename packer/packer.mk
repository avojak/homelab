BASE_IMAGE_NAME  := ubuntu-22.04-server
OUTPUT_DIR := output

AMD64_IMAGE_NAME := $(BASE_IMAGE_NAME)-amd64
AMD64_OVA_FILE := $(OUTPUT_DIR)/$(AMD64_IMAGE_NAME).ova
AMD64_TEMPLATE_FILE := $(AMD64_IMAGE_NAME)/template.json

ARM64_IMAGE_NAME := $(BASE_IMAGE_NAME)-arm64
ARM64_OVA_FILE := $(OUTPUT_DIR)/$(ARM64_IMAGE_NAME).ova
ARM64_TEMPLATE_FILE := $(ARM64_IMAGE_NAME)/template.json

SSH_KEY            := $(shell cat ../id_rsa.pub)
ESXI_ROOT_PASSWORD := $(shell cat ../.esxi_root_password)

.DEFAULT_GOAL := ova

# Build the amd64 .ova image
$(AMD64_OVA_FILE): $(AMD64_TEMPLATE_FILE)
	@echo Building $(AMD64_IMAGE_NAME)...
	@packer build \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(AMD64_IMAGE_NAME)' \
		$<

# Build the arm64 .ova image
$(ARM64_OVA_FILE): $(ARM64_TEMPLATE_FILE)
	@echo Building $(ARM64_IMAGE_NAME)...
	@packer build \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(ARM64_IMAGE_NAME)' \
		-var 'builder_host_password=$(ESXI_ROOT_PASSWORD)' \
		$<

# Build all .ova images
ova: $(AMD64_OVA_FILE) $(ARM64_OVA_FILE)

.PHONY: clean
clean:
	@$(RM) -rf $(AMD64_OVA_FILE) $(ARM64_OVA_FILE)

.PHONY: lint
lint:
	@echo Validating $(AMD64_TEMPLATE_FILE)...
	@packer validate \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(AMD64_IMAGE_NAME)' \
		$(AMD64_TEMPLATE_FILE)
	@echo Validating $(AMD64_TEMPLATE_FILE)...
	@packer validate \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(ARM64_IMAGE_NAME)' \
		-var 'builder_host_password=$(ESXI_ROOT_PASSWORD)' \
		$(ARM64_TEMPLATE_FILE)
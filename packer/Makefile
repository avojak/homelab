BASE_UBUNTU_IMAGE_NAME := ubuntu-22.04-server
OUTPUT_DIR := output

UBUNTU_AMD64_IMAGE_NAME := $(BASE_UBUNTU_IMAGE_NAME)-amd64
UBUNTU_AMD64_OVA_FILE := $(OUTPUT_DIR)/$(UBUNTU_AMD64_IMAGE_NAME).ova
UBUNTU_AMD64_TEMPLATE_FILE := $(UBUNTU_AMD64_IMAGE_NAME)/template.json

UBUNTU_ARM64_IMAGE_NAME := $(BASE_UBUNTU_IMAGE_NAME)-arm64
UBUNTU_ARM64_OVA_FILE := $(OUTPUT_DIR)/$(UBUNTU_ARM64_IMAGE_NAME).ova
UBUNTU_ARM64_TEMPLATE_FILE := $(UBUNTU_ARM64_IMAGE_NAME)/template.json

MACOS_VERSION := 11.7.4
MACOS_BUILD := 20G1120
MACOS_AMD64_IMAGE_NAME := macos-$(MACOS_VERSION)-amd64
MACOS_AMD64_ISO := $(MACOS_AMD64_IMAGE_NAME)/install_bits/macOS_$(MACOS_VERSION)_$(MACOS_BUILD).iso
MACOS_AMD64_OVA_FILE := $(OUTPUT_DIR)/$(MACOS_AMD64_IMAGE_NAME).ova
MACOS_AMD64_TEMPLATE_FILE := $(MACOS_AMD64_IMAGE_NAME)/template.pkr.hcl
MACOS_AMD64_VARS_FILE := $(MACOS_AMD64_IMAGE_NAME)/bigsur.pkrvars.hcl

SSH_KEY            := $(shell cat ../id_rsa.pub)
ESXI_ROOT_PASSWORD := $(shell cat ../.esxi_root_password)

.DEFAULT_GOAL := ova

# Build the Ubuntu amd64 .ova image
$(UBUNTU_AMD64_OVA_FILE): $(UBUNTU_AMD64_TEMPLATE_FILE)
	@echo Building $(UBUNTU_AMD64_IMAGE_NAME)...
	@packer build \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(UBUNTU_AMD64_IMAGE_NAME)' \
		$<

# Build the Ubuntu arm64 .ova image
$(UBUNTU_ARM64_OVA_FILE): $(UBUNTU_ARM64_TEMPLATE_FILE)
	@echo Building $(UBUNTU_ARM64_IMAGE_NAME)...
	@packer build \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(UBUNTU_ARM64_IMAGE_NAME)' \
		-var 'builder_host_password=$(ESXI_ROOT_PASSWORD)' \
		$<

# Download the macOS ISO using Mist
# $(MACOS_AMD64_ISO):
# 	cd $(MACOS_AMD64_IMAGE_NAME) && ./scripts/macosiso.sh $(MACOS_VERSION)

# Build the macOS amd64 .ova image
# $(MACOS_AMD64_OVA_FILE): $(MACOS_AMD64_TEMPLATE_FILE) $(MACOS_AMD64_VARS_FILE) $(MACOS_AMD64_ISO)
# 	@echo Building $(MACOS_AMD64_IMAGE_NAME)...
# 	@packer build \
# 		-force \
# 		-only=base.vmware-iso.macOS \
# 		-var-file $(MACOS_AMD64_VARS_FILE) \
# 		$<

.PHONY: ubuntu-amd64 ubuntu-arm64
ubuntu-amd64: $(UBUNTU_AMD64_OVA_FILE)
ubuntu-arm64: $(UBUNTU_ARM64_OVA_FILE)

# Build all .ova images
ova: $(UBUNTU_AMD64_OVA_FILE) $(UBUNTU_ARM64_OVA_FILE) # $(MACOS_AMD64_OVA_FILE)

.PHONY: clean
clean:
	@$(RM) -rf $(UBUNTU_AMD64_OVA_FILE) $(UBUNTU_ARM64_OVA_FILE)

.PHONY: lint
lint:
	@echo Validating $(UBUNTU_AMD64_TEMPLATE_FILE)...
	@packer validate \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(UBUNTU_AMD64_IMAGE_NAME)' \
		$(UBUNTU_AMD64_TEMPLATE_FILE)
	@echo Validating $(UBUNTU_AMD64_TEMPLATE_FILE)...
	@packer validate \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(UBUNTU_ARM64_IMAGE_NAME)' \
		-var 'builder_host_password=$(ESXI_ROOT_PASSWORD)' \
		$(UBUNTU_ARM64_TEMPLATE_FILE)
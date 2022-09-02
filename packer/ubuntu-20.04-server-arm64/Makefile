BASE_IMAGE_NAME    := ubuntu-20.04-server
ARM64_IMAGE_NAME   := $(BASE_IMAGE_NAME)-arm64

SSH_KEY := $(shell cat ../../id_rsa.pub)
ESXI_ROOT_PASSWORD := $(shell cat ../../.esxi_root_password)

ARM64_OVA_FILE := $(ARM64_IMAGE_NAME).ova
ARM64_TEMPLATE_FILE := template.json

.DEFAULT_GOAL := ova

$(ARM64_OVA_FILE):
	packer build \
		-var 'ssh_key=$(SSH_KEY)' \
		-var 'vm_name=$(ARM64_IMAGE_NAME)' \
		-var 'builder_host=192.168.1.230' \
		-var 'builder_host_username=root' \
		-var 'builder_host_password=$(ESXI_ROOT_PASSWORD)' \
		-var 'builder_host_datastore=datastore1' \
		-var 'builder_host_portgroup="VM Network"' \
		$(ARM64_TEMPLATE_FILE)

ova: $(ARM64_OVA_FILE)

iso:
	docker run --rm --privileged -v /dev:/dev -v ${PWD}:/build mkaczanowski/packer-builder-arm build template.json

.PHONY: clean
clean:
	@$(RM) -rf $(ARM64_IMAGE_NAME) $(AARCH64_IMAGE_NAME)

.PHONY: lint
lint:
	packer validate $(ARM64_TEMPLATE_FILE) $(AARCH64_TEMPLATE_FILE)
COREOS_VERSION := 39.20231119.3.0
COREOS_ARCH    := x86_64

CACHE_DIR := .cache

OVA_FILENAME := fedora-coreos-$(COREOS_VERSION)-vmware.$(COREOS_ARCH).ova
OVA_URL      := https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/$(COREOS_VERSION)/$(COREOS_ARCH)/$(OVA_FILENAME)
OVA_FILE     := $(CACHE_DIR)/$(OVA_FILENAME)

ESXI_ROOT_PASSWORD  := $(shell cat ../../../.esxi_root_password)
SSH_PUBLIC_KEY      := $(shell cat ../../../id_rsa.pub)
TERRAFORM_PLAN_FILE := infra.tfplan

$(CACHE_DIR):
	mkdir -p $@

$(OVA_FILE): | $(CACHE_DIR)
	wget -O $@ $(OVA_URL)

.PHONY: init
init: $(OVA_FILE)
	@echo Initializing Terraform...
	@terraform $@

.PHONY: plan
plan:
	@echo Planning Terraform deployment...
	@terraform $@ \
		-var 'esxi_password=$(ESXI_ROOT_PASSWORD)' \
		-var 'ova_file=$(OVA_FILE)' \
		-var 'ssh_public_key=$(SSH_PUBLIC_KEY)' \
		-out=$(TERRAFORM_PLAN_FILE) \
		$(CLI_PARAMETERS)

.PHONY: apply
apply:
	@echo Applying Terraform deployment...
	@terraform $@ $(TERRAFORM_PLAN_FILE)

.PHONY: plan-destroy
plan-destroy:
	@echo Destroying Terraform deployment...
	@terraform plan -destroy \
		-var='esxi_password=$(ESXI_ROOT_PASSWORD)' \
		-var 'ova_file=$(OVA_FILE)' \
		-var 'ssh_public_key=$(SSH_PUBLIC_KEY)' \
		-out=$(TERRAFORM_PLAN_FILE) \
		$(CLI_PARAMETERS)

.PHONY: refresh
refresh:
	@echo Refreshing Terraform state...
	@terraform refresh \
		-var='esxi_password=$(ESXI_ROOT_PASSWORD)' \
		-var 'ova_file=$(OVA_FILE)' \
		-var 'ssh_public_key=$(SSH_PUBLIC_KEY)' \
		$(CLI_PARAMETERS)

.PHONY: lint
lint:
	@echo Validating Terraform module...
	@terraform validate

.PHONY: format
format:
	@echo Formatting Terraform...
	@terraform fmt -recursive .

.PHONY: clean-ova
clean-ova:
	rm -rf $(CACHE_DIR)
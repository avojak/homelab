ESXI_ROOT_PASSWORD  := $(shell cat ../.esxi_root_password)
TERRAFORM_PLAN_FILE := homelab.tfplan

ifdef TARGET
CLI_PARAMETERS="-target=$(TARGET)"
endif

.PHONY: init
init:
	@echo Initializing Terraform...
	@terraform $@

.PHONY: plan
plan:
	@echo Planning Terraform deployment...
	@terraform $@ -var='esxi_password=$(ESXI_ROOT_PASSWORD)' -out=$(TERRAFORM_PLAN_FILE) $(CLI_PARAMETERS)

.PHONY: apply
apply:
	@echo Applying Terraform deployment...
	@terraform $@ $(TERRAFORM_PLAN_FILE)

.PHONY: destroy
destroy:
	@echo Destroying Terraform deployment...
	@terraform $@ -var='esxi_password=$(ESXI_ROOT_PASSWORD)'

.PHONY: lint
lint:
	@echo Validating Terraform module...
	@terraform validate

.PHONY: format
format:
	@echo Formatting Terraform...
	@terraform fmt -recursive .
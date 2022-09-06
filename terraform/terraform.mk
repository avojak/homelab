ESXI_ROOT_PASSWORD := $(shell cat ../.esxi_root_password)

.PHONY: init
init:
	@echo Initializing Terraform...
	@terraform $@

.PHONY: plan
plan:
	@echo Planning Terraform deployment...
	@terraform $@ -var='esxi_password=$(ESXI_ROOT_PASSWORD)'

.PHONY: apply
apply:
	@echo Applying Terraform deployment...
	@terraform $@ -var='esxi_password=$(ESXI_ROOT_PASSWORD)'

.PHONY: destroy
destroy:
	@echo Destroying Terraform deployment...
	@terraform $@ -var='esxi_password=$(ESXI_ROOT_PASSWORD)'

.PHONY: lint
lint:
	@echo Validating Terraform module...
	@terraform validate
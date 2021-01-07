init:
	terraform init esxi01
	terraform init esxi02
plan:
	terraform plan esxi01
	terraform plan esxi02
apply:
	terraform apply esxi01
	terraform apply esxi02
destroy:
	terraform destroy esxi01
	terraform destroy esxi02

.PHONY: lint
lint:
	terraform validate esxi01
	terraform validate esxi02
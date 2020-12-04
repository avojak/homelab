PASSWORD = $(shell bash -c 'read -s -p "ESXi Password: " pwd; echo $$pwd')

deploy:
	terraform init
	@terraform plan -var 'esxi_password=$(PASSWORD)'
	@terraform apply -var 'esxi_password=$(PASSWORD)'

.PHONY: lint
lint:
	terraform validate
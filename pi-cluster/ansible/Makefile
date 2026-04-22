REQUIREMENTS_FILE   := requirements.yml
VAULT_FILE := inventories/production/group_vars/guests/vault.yml
VAULT_PASSWORD_FILE := .vault-password-file
ANSIBLE_EXECUTOR_IMAGE := avojak/pi-cluster-ansible-executor:latest

init: $(REQUIREMENTS_FILE)
	ansible-galaxy install -r $< --force

show-inventory:
	ansible-inventory \
		-i inventories/production/inventory.yml \
		--graph \
		--vars \
		--vault-password-file $(VAULT_PASSWORD_FILE)

encrypt-vault:
	ansible-vault \
		encrypt \
		--vault-password-file $(VAULT_PASSWORD_FILE) \
		$(VAULT_FILE)

decrypt-vault:
	ansible-vault \
		decrypt \
		--vault-password-file $(VAULT_PASSWORD_FILE) \
		$(VAULT_FILE)

install:
	docker run -it --rm \
		-v $(shell cd .. && pwd):/apps \
		-v $(shell cd ../../ && pwd)/id_rsa:/id_rsa \
		-w /apps/ansible \
		$(ANSIBLE_EXECUTOR_IMAGE) \
		ansible-playbook play.yml \
		--vault-password-file $(VAULT_PASSWORD_FILE) \
		--inventory inventories/production/inventory.yml

lint:
	ansible-lint

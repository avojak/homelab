REQUIREMENTS_FILE := requirements.yml

init: $(REQUIREMENTS_FILE)
	ansible-galaxy install -r $< --force

install:
	ansible-playbook play.yml --vault-password-file .vault-password-file --inventory inventories/production --limit minecraft.vojak.cloud

lint:
	ansible-lint

decrypt-vault:
	ansible-vault decrypt --vault-password-file .vault-password-file inventories/production/group_vars/guests/vault.yml

encrypt-vault:
	ansible-vault encrypt --vault-password-file .vault-password-file inventories/production/group_vars/guests/vault.yml

REQUIREMENTS_FILE := requirements.yml

init: $(REQUIREMENTS_FILE)
	ansible-galaxy install -r $< --force

install:
	ansible-playbook play.yml --vault-password-file .vault-password-file --inventory inventories/production

lint:
	ansible-lint
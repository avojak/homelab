REQUIREMENTS_FILE := requirements.yml

init: $(REQUIREMENTS_FILE)
	ansible-galaxy install -r $< --force

run:
	ansible-playbook play.yml --vault-password-file .vault-password-file --limit "homelab-mon" --tags "plausible"
#	ansible-playbook play.yml --vault-password-file .vault-password-file --limit "homelab-app-01"
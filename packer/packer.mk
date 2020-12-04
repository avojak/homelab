IMAGE_NAME=ubuntu-18.04-server
SSH_KEY:=$(shell cat ../id_rsa.pub)

ova:
	packer build -var 'ssh_key=$(SSH_KEY)' ./$(IMAGE_NAME)-template.json

.PHONY: clean
clean:
	@$(RM) -rf ./output/$(IMAGE_NAME)/

.PHONY: lint
lint:
	packer validate ./$(IMAGE_NAME)-template.json
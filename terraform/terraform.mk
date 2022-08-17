# MAKE_DIR = $(PWD)

ESXI01_DIR    := esxi01
# ESXI02_DIR    := esxi02

ESXI01_MAKEFILE    := esxi01.mk
# ESXI02_MAKEFILE    := esxi02.mk

init:
	@$(MAKE) -C $(ESXI01_DIR) -f $(ESXI01_MAKEFILE) init
#	@$(MAKE) -C $(ESXI02_DIR) -f $(ESXI02_MAKEFILE) init
plan:
	@$(MAKE) -C $(ESXI01_DIR) -f $(ESXI01_MAKEFILE) plan
#	@$(MAKE) -C $(ESXI02_DIR) -f $(ESXI02_MAKEFILE) plan
apply:
	@$(MAKE) -C $(ESXI01_DIR) -f $(ESXI01_MAKEFILE) apply
#	@$(MAKE) -C $(ESXI02_DIR) -f $(ESXI02_MAKEFILE) apply
destroy:
	@$(MAKE) -C $(ESXI01_DIR) -f $(ESXI01_MAKEFILE) destroy
#	@$(MAKE) -C $(ESXI02_DIR) -f $(ESXI02_MAKEFILE) destroy

.PHONY: lint
lint:
	@$(MAKE) -C $(ESXI01_DIR) -f $(ESXI01_MAKEFILE) $@
#	@$(MAKE) -C $(ESXI02_DIR) -f $(ESXI02_MAKEFILE) $@
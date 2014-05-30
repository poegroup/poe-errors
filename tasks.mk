PROJECT      ?= $(notdir $(CURDIR))
DESCRIPTION  ?= Our poe-error pages
ORGANIZATION ?= $(PROJECT)
REPO         ?= $(ORGANIZATION)/$(PROJECT)

POE_ERRORS := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
PATH := $(POE_ERRORS)/node_modules/.bin:$(PATH)

include $(POE_ERRORS)/node_modules/poe-ui-kit/build.mk

ifeq ($(MAKECMDGOALS),init)

DIRS  = $(shell find $(POE_ERRORS)/files -type d -name '*[a-zA-Z]' | sed 's:^$(POE_ERRORS)/files/::')
FILES = $(shell find $(POE_ERRORS)/files -type f                   | sed 's:^$(POE_ERRORS)/files/::')

### Init files
init: $(DIRS) $(FILES) init_install install

init_install:
	@echo 'Installing remaining dependencies...'
	@npm install --silent

$(DIRS):
	@mkdir -p $@

$(FILES):
	@awk '{gsub(/PROJECT/, "$(PROJECT)"); gsub(/DESCRIPTION/, "$(DESCRIPTION)"); gsub(/REPO/, "$(REPO)");print}' \
		$(POE_ERRORS)/files/$@ > $@

.PHONY: init init_install

endif

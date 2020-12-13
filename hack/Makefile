.DEFAULT_GOAL := default
SHELL = /usr/bin/env bash -eo pipefail



MKFILE_DIR = $(abspath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
PLATFORM := $(shell if echo $$OSTYPE | grep -q darwin; then echo darwin; else echo linux; fi)
LOCAL_DIR = $(abspath $(MKFILE_DIR)/../.local)


BIN_DIR = $(LOCAL_DIR)/bin
LIB_DIR = $(LOCAL_DIR)/lib
TEMP_DIR = $(LOCAL_DIR)/tmp



# next LTS: 14.13.0
NODEJS_VERSION ?= 12.16.3
NPM_VERSION ?= 6.14.4
MONGODB_VERSION ?= 4.2.6

REACT_APP_VERSION = 3.4.1



NODEJS_URL = https://nodejs.org/dist/v$(NODEJS_VERSION)/node-v$(NODEJS_VERSION)-$(PLATFORM)-x64.tar.gz
NODEJS_ARTIFACT = $(TEMP_DIR)/node-v$(NODEJS_VERSION)-$(PLATFORM)-x64.tar.gz
NODEJS_ARCHIVE = $(patsubst %.tar.gz,%,$(notdir $(NODEJS_ARTIFACT)))
NODEJS_BIN = $(BIN_DIR)/node
NPM_BIN = $(BIN_DIR)/npm
NODEJS_SHA256 ?= $(shell cat $(MKFILE_DIR)/versions/nodejs.256.sums | grep v$(NODEJS_VERSION)-$(PLATFORM)-x64 | awk '{ print $$ 1 }')


ifeq ($(PLATFORM), darwin)
MONGODB_URL = https://fastdl.mongodb.org/osx/mongodb-macos-x86_64-$(MONGODB_VERSION).tgz
else ifeq ($(PLATFORM), linux)
# NOTE: hard-coded Debian version. Others can be found here: https://www.mongodb.com/download-center/community
MONGODB_URL = https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian10-$(MONGODB_VERSION).tgz
else
	fail 'Unknown platform. No condition met'
endif
MONGODB_ARTIFACT = $(TEMP_DIR)/mongodb-$(PLATFORM)-$(MONGODB_VERSION).tar.gz
MONGODB_ARCHIVE = $(patsubst %.tar.gz,%,$(notdir $(MONGODB_ARTIFACT)))
MONGODB_BIN = $(BIN_DIR)/mongod
MONGODB_SHA256 ?= $(shell cat $(MKFILE_DIR)/versions/mongodb.256.sums | grep $(PLATFORM)-x86_64-$(MONGODB_VERSION) | awk '{ print $$ 1 }')




default: all

all: install



.PHONY: install
install: node npm mongod


$(LOCAL_DIR)/%/:
	mkdir -p $(@)


.PHONY: clean
clean:
	rm -rf \
		$(LOCAL_DIR)



.PHONY: node
node: $(NODEJS_BIN)
$(NODEJS_BIN): | $(NODEJS_ARTIFACT) $(BIN_DIR)/
	@ [ $$(openssl dgst -sha256 "$(NODEJS_ARTIFACT)" | awk '{ print $$ 2 }') == $(NODEJS_SHA256) ] || ( echo "Invalid SHA256." && rm $(NODEJS_ARTIFACT) && exit 1 )
	tar \
		--extract \
		--verbose \
		--strip-components 2 \
		--directory "$(BIN_DIR)" \
		--file "$(NODEJS_ARTIFACT)" \
		$(NODEJS_ARCHIVE)/bin/node
	chmod +x "$@"

$(NODEJS_ARTIFACT): | $(TEMP_DIR)/
	curl \
		--silent --show-error \
		--location \
		$(NODEJS_URL) \
		> $(NODEJS_ARTIFACT)


.PHONY: npm
npm: $(NPM_BIN)
npm: export PATH := $(BIN_DIR):$(PATH)
$(NPM_BIN): | $(NODEJS_BIN)
	mkdir -p $(LIB_DIR)
	tar \
		--extract \
		--verbose \
		--strip-components 2 \
		--directory "$(LIB_DIR)" \
		--file "$(NODEJS_ARTIFACT)" \
		$(NODEJS_ARCHIVE)/lib/node_modules
	chmod +x $(LIB_DIR)/node_modules/npm/bin/npm-cli.js
	ln -s $(LIB_DIR)/node_modules/npm/bin/npm-cli.js $(NPM_BIN)
	npm install -g npm@$(NPM_VERSION)


.PHONY: mongod
mongod: $(MONGODB_BIN)
$(MONGODB_BIN): | $(MONGODB_ARTIFACT) $(BIN_DIR)/
	@ [ $$(openssl dgst -sha256 "$(MONGODB_ARTIFACT)" | awk '{ print $$ 2 }') == $(MONGODB_SHA256) ] || ( echo "Invalid SHA256." && rm $(MONGODB_ARTIFACT) && exit 1 )
	mkdir -p $(TEMP_DIR)/$(MONGODB_ARCHIVE)
	tar \
		--extract \
		--verbose \
		--strip-components 2 \
		--directory "$(TEMP_DIR)/$(MONGODB_ARCHIVE)" \
		--file "$(MONGODB_ARTIFACT)"
	mv $(TEMP_DIR)/$(MONGODB_ARCHIVE)/mongod "$@"
	chmod +x "$@"
	rm -rf $(TEMP_DIR)/$(MONGODB_ARCHIVE)

$(MONGODB_ARTIFACT): | $(TEMP_DIR)/
	curl \
		--silent --show-error \
		--location \
		$(MONGODB_URL) \
		> $(MONGODB_ARTIFACT)




.PHONY: update-react-app-template
update-react-app-template: export PATH := $(BIN_DIR):$(PATH)
update-react-app-template:
	rm -rf $(TEMP_DIR)/npm-project-scope
	mkdir -p $(TEMP_DIR)/npm-project-scope
	cd $(TEMP_DIR)/npm-project-scope \
		&& npm install --save-dev react-scripts@$(REACT_APP_VERSION) \
		&& npm init react-app $(TEMP_DIR)/npm-project-scope/cra
	cp \
		$(TEMP_DIR)/npm-project-scope/cra/src/* \
		$(MKFILE_DIR)/../app/client/src/
	cp \
		$(TEMP_DIR)/npm-project-scope/cra/public/* \
		$(MKFILE_DIR)/../app/client/public/
	cp \
		$(TEMP_DIR)/npm-project-scope/cra/package.json \
		$(MKFILE_DIR)/../app/client/
	rm -rf \
		$(MKFILE_DIR)/../app/client/src/logo.svg

.DEFAULT_GOAL := default
SHELL = /usr/bin/env bash -eo pipefail



MKFILE_DIR = $(abspath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
LOCAL_DIR = $(abspath $(MKFILE_DIR)/.local)


DATA_DIR = $(LOCAL_DIR)/data
LOG_DIR = $(LOCAL_DIR)/logs


APP_NODE_MODULE_DIRS = $(foreach dir, client server, $(subst %,$(dir),$(MKFILE_DIR)/app/%/node_modules))


# NOTE: make sure to use binaries installed via ./hack/Makefile if exist
export PATH := $(LOCAL_DIR)/bin:$(PATH)




default: all

all: install build




.PHONY: install
install: $(APP_NODE_MODULE_DIRS)
$(APP_NODE_MODULE_DIRS):
	cd $(@D) \
	&& npm install


$(LOCAL_DIR)/%/:
	mkdir -p $(@)


.PHONY: clean
clean:
	for nodeModulesDir in $(APP_NODE_MODULE_DIRS); do \
		rm -rf "$${nodeModulesDir}"; \
	done



.PHONY: build
build: CLIENT_BUILD_PATH ?= $(MKFILE_DIR)/app/server/src/public
build: SERVER_PUBLIC_URL ?= http://localhost:3000
build:
	rm -rf $(CLIENT_BUILD_PATH)
	cd $(MKFILE_DIR)/app/client \
	&& \
		PUBLIC_URL=$(SERVER_PUBLIC_URL) \
		BUILD_PATH=$(CLIENT_BUILD_PATH) \
		node ./scripts/build.js


.PHONY: test
test: randomString = $(shell LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 32 | head -n 1)
test:
	cd $(MKFILE_DIR)/app/client \
	&& npm run test

	cd $(MKFILE_DIR)/app/server \
	&& \
		PORT=3002 \
		MONGODB_URL=mongodb://localhost:27017/$(randomString) \
		JWT_SECRET=$(randomString) \
	 	npm run test




.PHONY: dev-test-client
dev-test-client:
	cd $(MKFILE_DIR)/app/client \
	&& npm run test:dev


.PHONY: dev-start-db
dev-start-db: | $(LOG_DIR)/ $(DATA_DIR)/
	mkdir -p $(DATA_DIR)/db
	mongod --config $(MKFILE_DIR)/hack/local.mongod.conf


.PHONY: dev-start-app
dev-start-app: build
	cd $(MKFILE_DIR)/app/server \
	&& npm run start:dev



.PHONY: run
run: PUBLIC_URL = http://localhost
run: SERVER_PORT = 3001
run: DB_HOST = localhost
run: DB_PORT = 27017
run: | $(DATA_DIR)/ $(LOG_DIR)/
	mkdir -p $(DATA_DIR)/db

	make build SERVER_PUBLIC_URL=$(PUBLIC_URL):$(SERVER_PORT)

	(exec mongod \
		--port $(DB_PORT) \
		--bind_ip $(DB_HOST) \
		--logpath /dev/stdout \
		--dbpath $(DATA_DIR)/db \
	) & PIDS[1]=$$!; \
	\
	(PORT=$(SERVER_PORT) \
	MONGODB_URL=mongodb://$(DB_HOST):$(DB_PORT)/todo-app \
	JWT_SECRET=myjwtsecret \
	exec node $(MKFILE_DIR)/app/server/src/index.js \
	) & PIDS[2]=$$!; \
	\
	for PID in $${PIDS[*]}; do wait $${PID}; done;




.PHONY: deps
deps:
	NODEJS_VERSION=12.21.0  \
	NPM_VERSION=6.14.11     \
	MONGODB_VERSION=4.2.12  \
		make -C $(MKFILE_DIR)/hack \
		install
	@echo ''
	@echo 'In order to use the installed dependencies, the $$PATH variable must be adjusted.'
	@echo 'Run:'
	@echo ''
	@echo '  export PATH=$$(pwd)/.local/bin:$${PATH}'
	@echo ''


.PHONY: nuke
nuke:
	cd $(MKFILE_DIR)/hack \
		&& make clean
	make clean

.DEFAULT_GOAL := default
SHELL = /usr/bin/env bash -eo pipefail



MKFILE_DIR = $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
LOCAL_DIR := $(shell echo $$(cd "$(MKFILE_DIR)" && pwd)/.local)


DATA_DIR := $(LOCAL_DIR)/data
LOG_DIR  := $(LOCAL_DIR)/logs
TEMP_DIR := $(LOCAL_DIR)/temp


APP_NODE_MODULE_DIRS = $(foreach dir, client server, $(subst %,$(dir),$(MKFILE_DIR)/app/%/node_modules))



default: install build


.PHONY: install
install: $(APP_NODE_MODULE_DIRS)
$(APP_NODE_MODULE_DIRS):
	cd $(@D) \
	&& npm install


$(LOCAL_DIR)/%/:
	mkdir -p $(@)


.PHONY: clean
clean:
	rm -rf \
		$(APP_NODE_MODULE_DIRS) \
		"$(TEMP_DIR)" \
		"$(LOCAL_DIR)/dist"



.PHONY: build
build: SERVER_PUBLIC_URL ?= http://127.0.0.1:3001
build: APP_BUILD_PATH ?= $(TEMP_DIR)
build: $(TEMP_DIR)/
	rm -rf "$(APP_BUILD_PATH)"

	cp -r "$(MKFILE_DIR)"/app/server/src "$(APP_BUILD_PATH)"
	cp "$(MKFILE_DIR)"/app/server/package* "$(APP_BUILD_PATH)/"
	cd "$(APP_BUILD_PATH)" \
	&& \
		npm install --prod --no-audit --no-fund \
		&& rm -rf ./package*

	cd "$(MKFILE_DIR)/app/client" \
	&& \
		npm install --production=false --no-audit --no-fund \
		&& \
		PUBLIC_URL=$(SERVER_PUBLIC_URL) \
		BUILD_PATH="$(APP_BUILD_PATH)/public" \
			node ./scripts/build.js


.PHONY: test
test: randomString = $(shell LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 32 | head -n 1)
test:
	cd "$(MKFILE_DIR)/app/client" \
	&& npm run test

	cd "$(MKFILE_DIR)/app/server" \
	&& \
		PORT=3002 \
		MONGODB_URL=mongodb://localhost:27017/$(randomString) \
		JWT_SECRET=$(randomString) \
	 	npm run test




.PHONY: dev-test-client
dev-test-client:
	cd "$(MKFILE_DIR)/app/client" \
	&& npm run test:dev


.PHONY: dev-start-db
dev-start-db: $(LOG_DIR)/ $(DATA_DIR)/ $(DATA_DIR)/db/
	mongod --config "$(MKFILE_DIR)/app/server/dev.mongod.conf"


.PHONY: dev-start-app
dev-start-app:
	cd "$(MKFILE_DIR)/app/client" \
	&& \
		PUBLIC_URL=$(SERVER_PUBLIC_URL) \
		BUILD_PATH="$(MKFILE_DIR)/app/server/src/public" \
		node ./scripts/build.js
	cd "$(MKFILE_DIR)/app/server" \
	&& npm run start:dev



.PHONY: run
run: BUILD_PATH = $(LOCAL_DIR)/dist
run: PUBLIC_URL = http://localhost
run: SERVER_PORT = 3000
run: DB_HOST = localhost
run: DB_PORT = 27017
run: $(DATA_DIR)/ $(LOG_DIR)/ $(DATA_DIR)/db/
	make build \
		APP_BUILD_PATH="$(BUILD_PATH)" \
		SERVER_PUBLIC_URL=$(PUBLIC_URL):$(SERVER_PORT)

	(exec mongod \
		--port $(DB_PORT) \
		--bind_ip $(DB_HOST) \
		--logpath /dev/stdout \
		--dbpath "$(DATA_DIR)/db" \
	) & PIDS[1]=$$!; \
	\
	(PORT=$(SERVER_PORT) \
	MONGODB_URL=mongodb://$(DB_HOST):$(DB_PORT)/todo-app \
	JWT_SECRET=myjwtsecret \
	exec node "$(BUILD_PATH)/index.js" \
	) & PIDS[2]=$$!; \
	\
	for PID in $${PIDS[*]}; do wait $${PID}; done;

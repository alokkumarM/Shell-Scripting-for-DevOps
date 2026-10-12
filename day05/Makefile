.PHONY: build up down clean

DOCKER_COMPOSE := docker compose

OS := $(shell uname)

build:
ifeq ($(OS),Linux)
	echo "Running in $(OS)"
	$(DOCKER_COMPOSE) build
endif
up: build
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean:
	docker system prune 

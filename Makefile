IMAGE_NAME := "azukiapp/elixir"

# bins
DOCKER := $(shell which adocker || which docker)

all: build

build:
	${DOCKER} build -t ${IMAGE_NAME} 1.0
	${DOCKER} build -t ${IMAGE_NAME}:1.0 1.0
	${DOCKER} build -t ${IMAGE_NAME}:1.0.5 1.0

build-no-cache:
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME} 1.0
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:1.0 1.0
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:1.0.5 1.0

.PHONY: all build build-no-cache

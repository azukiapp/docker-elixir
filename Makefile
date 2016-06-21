IMAGE_NAME := "azukiapp/elixir"

# bins
DOCKER := $(shell which adocker || which docker)

all: build test

build:
	${DOCKER} build -t ${IMAGE_NAME}:latest   1.2
	${DOCKER} build -t ${IMAGE_NAME}:1.2      1.2
	${DOCKER} build -t ${IMAGE_NAME}:1.1      1.1
	${DOCKER} build -t ${IMAGE_NAME}:1.0      1.0

build-no-cache:
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:latest   1.2
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:1.2      1.2
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:1.1      1.1
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:1.0      1.0

test:
	# run bats of test to each version
	./test.sh 1.2 1.2.6
	./test.sh 1.1 1.1.1
	./test.sh 1.0 1.0.5

.PHONY: all build build-no-cache test

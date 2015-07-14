DOCKER=$(shell if [ "$(which adocker)" ]; then which adocker; else which docker; fi)

.PHONY: all
all:
	adocker build -t azukiapp/elixir 1.0
	adocker build -t azukiapp/elixir:1.0 1.0

.PHONY: no-cache
no-cache:
	adocker build --rm --no-cache -t azukiapp/elixir 1.0
	adocker build --rm --no-cache -t azukiapp/elixir:1.0 1.0

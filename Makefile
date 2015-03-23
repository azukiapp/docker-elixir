# `adocker` is alias to `azk docker`
all:
	adocker build -t azukiapp/elixir .

no-cache:
	adocker build --rm --no-cache -t azukiapp/elixir .

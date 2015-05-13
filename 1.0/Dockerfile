FROM azukiapp/erlang
MAINTAINER Azuki <support@azukiapp.com>

RUN apt-get -qq update && \
    apt-get install -qqy erlang-inets elixir && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install local Elixir hex and rebar
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force

CMD ["iex"]

FROM azukiapp/erlang
MAINTAINER Azuki <support@azukiapp.com>

# Install local Elixir hex and rebar
RUN  apt-get -qq update \
  && apt-get install -qqy erlang-inets elixir \
  && /usr/local/bin/mix local.hex --force \
  && /usr/local/bin/mix local.rebar --force \
  && apt-get autoremove --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["iex"]

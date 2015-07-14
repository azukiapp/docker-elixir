FROM gullitmiranda/node
MAINTAINER Gullit Miranda <gullitmiranda@gmail.com>

ENV REPOSITORY=@testing
ENV VERSION=1.0.4

# Install local Elixir hex and rebar
RUN  apk add --update elixir${REPOSITORY}=${VERSION}-r0 \
  && mix local.hex --force \
  && mix local.rebar --force \
  && rm -rf /var/cache/apk/* /var/tmp/* \

CMD ["iex"]

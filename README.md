[azukiapp/elixir](http://images.azk.io/#/elixir)
==================

Base docker image to run **Elixir** applications in [azk.io][azk]

[![Circle CI][circleci-badge]][circleci]
[![][imagelayers-badge]][imagelayers]

Elixir Versions (tags)
---

<versions>
- [`latest`, `1`, `1.2`, `1.2.6`](https://github.com/azukiapp/docker-elixir/blob/v1.2.6/1.2/Dockerfile)
- [`1.2.0`](https://github.com/azukiapp/docker-elixir/blob/v1.2.0/1.2/Dockerfile)
- [`1.1`, `1.1.1`](https://github.com/azukiapp/docker-elixir/blob/v1.1.1/1.1/Dockerfile)
- [`1.0`, `1.0.5`](https://github.com/azukiapp/docker-elixir/blob/v1.0.5/1.0/Dockerfile)
</versions>

Image content use http://images.azk.io/#/erlang (v18)

### Usage with `azk`

Example of using this image with [azk][azk]:

```js
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

// Adds the systems that shape your system
systems({
  "elixir": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More info about elixir image: http://images.azk.io/#/elixir?from=images-azkfile-elixir
    image: {"docker": "azukiapp/elixir:1.2"},
    // or use Dockerfile to custimize your image
    //image: {"dockerfile": "./Dockerfile"},
    // Steps to execute before running instances
    provision: [
      // "mix local.hex --force", // update mix
      "mix do deps.get, compile",
      // Phoenix provision steps
      // "mix ecto.create",
      // "mix ecto.migrate",
    ],
    workdir: "/azk/#{manifest.dir}",
    command: "mix run --no-halt",
    // command: "mix phoenix.server --no-deps-check",
    wait: {"retry": 20, "timeout": 1000},
    mounts: {
      "/azk/#{manifest.dir}"       : sync("."),
      // Elixir
      "/root/.hex"                 : persistent("#{system.name}/.hex"),
      "/azk/#{manifest.dir}/deps"  : persistent("#{system.name}/deps"),
      "/azk/#{manifest.dir}/_build": persistent("#{system.name}/_build"),
    },
    scalable: {"default": 1},
    http: {
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    ports: {
      http: "4000",
    },
    envs: {
      // set instances variables
      HEX_HOME: "/azk/#{manifest.dir}/.hex/"
      MIX_ENV: "dev"
    },
  },
});
```

## Extend image with `Dockerfile`

Install more packages:

```dockerfile
# Dockerfile
FROM azukiapp/elixir:1.2

# install nodejs
# install postgresql-client
RUN  apk add --update nodejs postgresql-client \
  && rm -rf /var/cache/apk/* /var/tmp/* \

CMD ["iex"]
```

To build the image:

```sh
$ docker build -t azukiapp/elixir:1.2 .
```

To more packages, access [alpine packages][alpine-packages]

### Usage with `docker`

To run the image and bind to port 4000:

```sh
$ docker run -it --name my-app -p 4000:4000 -v "$PWD":/myapp -w /myapp azukiapp/elixir:1.2 iex
```

Logs
---

```sh
# with azk
$ azk logs my-app

# with docker
$ docker logs <CONTAINER_ID>
```

## License

"Azuki", "azk" and the Azuki logo are Copyright 2013-2016 Azuki Serviços de Internet LTDA.

**azk** source code is released under [Apache 2 License][LICENSE].

Check LEGAL and LICENSE files for more information.

[azk]: http://azk.io
[alpine-packages]: http://pkgs.alpinelinux.org/

[circleci]: https://circleci.com/gh/azukiapp/docker-elixir
[circleci-badge]: https://circleci.com/gh/azukiapp/docker-elixir.svg?style=svg

[imagelayers]: https://imagelayers.io/?images=azukiapp/elixir:latest,azukiapp/elixir:1.2,azukiapp/elixir:1.1,azukiapp/elixir:1.0
[imagelayers-badge]: https://imagelayers.io/badge/azukiapp/elixir:latest.svg

[issues]: https://github.com/azukiapp/docker-elixir/issues
[license]: https://github.com/azukiapp/docker-elixir/blob/master/LICENSE

[azukiapp/elixir](http://images.azk.io/#/elixir)
==================

Base docker image to run **Elixir** applications in [`azk`][azk]

[![Circle CI](https://circleci.com/gh/azukiapp/docker-elixir.svg?style=svg)][circle-ci]
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/azukiapp/elixir/latest.svg?style=plastic)][imageslayers]
[![ImageLayers Layers](https://img.shields.io/imagelayers/layers/azukiapp/elixir/latest.svg?style=plastic)][imageslayers]

Elixir Versions (tags)
---

<versions>
- [`latest`, `1`, `1.1`, `1.1.1`](https://github.com/azukiapp/docker-elixir/blob/master/1.1/Dockerfile)
- [`1.0`, `1.0.5`](https://github.com/azukiapp/docker-elixir/blob/master/1.0/Dockerfile)
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
    image: {"docker": "azukiapp/elixir:1.0"},
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
FROM azukiapp/elixir:1.0

# install nodejs
# install postgresql-client
RUN  apk add --update nodejs postgresql-client \
  && rm -rf /var/cache/apk/* /var/tmp/* \

CMD ["iex"]
```

To build the image:

```sh
$ docker build -t azukiapp/elixir:1.0 .
```

To more packages, access [alpine packages][alpine-packages]

### Usage with `docker`

To run the image and bind to port 4000:

```sh
$ docker run -it --name my-app -p 4000:4000 -v "$PWD":/myapp -w /myapp azukiapp/elixir:1.0 iex
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

Azuki Dockerfiles distributed under the [Apache License][license].

[azk]: http://azk.io
[alpine-packages]: http://pkgs.alpinelinux.org/

[circle-ci]: https://circleci.com/gh/azukiapp/docker-elixir
[imageslayers]: https://imagelayers.io/?images=azukiapp/elixir:latest

[issues]: https://github.com/azukiapp/docker-elixir/issues
[license]: https://github.com/azukiapp/docker-elixir/blob/master/LICENSE

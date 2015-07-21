[azukiapp/elixir](http://images.azk.io/#/elixir)
==================

Base docker image to run **Elixir** applications in [`azk`](http://azk.io)

Versions (tags)
---

<versions>
- [`latest`, `1`, `1.0`, `1.0.5`](https://github.com/gullitmiranda/docker-elixir/blob/master/1.0.5/Dockerfile)
- [`1.0.4`](https://github.com/gullitmiranda/docker-elixir/blob/v1.0.4/1.0.4/Dockerfile)
- [`1.0.4-etp17`](https://github.com/gullitmiranda/docker-elixir/blob/v1.0.4-etp17/1.0.4/Dockerfile)

</versions>

Image content:
---

- Alpine 3.2
- Git
- VIM

Database:

- Erlang
- Elixir

### Usage with `azk`

Example of using this image with [azk](http://azk.io):

```js
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */
 
// Adds the systems that shape your system
systems({
  "elixir": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More images:  http://images.azk.io
    image: {"docker": "gullitmiranda/elixir"},
    // Steps to execute before running instances
    provision: [
      "mix do deps.get, compile"
    ],
    workdir: "/azk/#{manifest.dir}",
    command: "mix run --no-halt",
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
    },
  },
  // Or Phoenix Framework
  "phoenix": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More images:  http://images.azk.io
    image: {"docker": "gullitmiranda/elixir"},
    // Steps to execute before running instances
    provision: [
      // "mix local.hex --force", // update mix
      "npm install",
      "mix do deps.get, compile",
      "mix ecto.create",
      "mix ecto.migrate",
    ],
    workdir: '/azk/#{manifest.dir}',
    shell: "/bin/bash",
    // Phoenix Framework
    command: "mix phoenix.server --no-deps-check",
    wait: {"retry": 20, "timeout": 1000},
    mounts: {
      "/azk/#{manifest.dir}"                : sync("."),
      // Elixir
      "/root/.hex"                          : persistent("#{system.name}/.hex"),
      "/azk/#{manifest.dir}/deps"           : persistent("#{system.name}/deps"),
      "/azk/#{manifest.dir}/_build"         : persistent("#{system.name}/_build"),
      // Phoenix
      "/azk/#{manifest.dir}/node_modules"   : persistent("#{system.name}/node_modules"),
      "/azk/#{manifest.dir}/priv/static/js" : persistent("#{system.name}/priv/static/js"),
      "/azk/#{manifest.dir}/priv/static/css": persistent("#{system.name}/priv/static/css"),
    },
    scalable: {"default": 1},
    http: {
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    ports: {
      http: "4000",
    },
    envs: {
      MIX_ENV: "dev"
    },
  },
});
```

### Usage with `docker`

To create the image `gullitmiranda/elixir`, execute the following command on the elixir folder:

```sh
$ docker build -t gullitmiranda/elixir .
```

To run the image and bind to port 4000:

```sh
$ docker run -it --rm --name my-app -p 4000:4000 -v "$PWD":/myapp -w /myapp gullitmiranda/elixir mix run --no-halt
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

[license]: ./LICENSE

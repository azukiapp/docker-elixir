/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */
// Adds the systems that shape your system
systems({
  "v11": {
    image: {"docker": "azukiapp/elixir:1.1"},
    workdir: "/azk/#{manifest.dir}/test",
    mounts: {
      '/azk/#{manifest.dir}/test'       : sync("./test"),
      '/azk/#{manifest.dir}/test/deps'  : persistent("./test/deps"),
      '/azk/#{manifest.dir}/test/_build': persistent("./test/_build"),
      '/root/.hex'                      : persistent("#{env.HOME}/.hex"),
    },
    wait: false,
    scalable: {default: 0},
    envs: {
      // if you're setting it in a .env file
      MIX_ENV: "test",
      IEX_VERSION: "1.1.1"
    },
  },
  v10: {
    extends: "v11",
    image: {"docker": "azukiapp/elixir:1.0"},
    envs: {
      // if you're setting it in a .env file
      MIX_ENV: "test",
      IEX_VERSION: "1.0.5"
    },
  },
});

/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */
// Adds the systems that shape your system

var version = env.ELIXIR_TEST_VERSION;
var pattern = env.ELIXIR_TEST_VERSION_PATTERN;

systems({
  "elixir": {
    image: { "docker": "azukiapp/elixir:" + version },
    workdir: "/azk/#{manifest.dir}/test",
    mounts: {
      '/azk/#{manifest.dir}/test'       : sync("./test"),
      '/azk/#{manifest.dir}/test/deps'  : persistent("./test-" + version + "/deps"),
      '/azk/#{manifest.dir}/test/_build': persistent("./test-" + version + "/_build"),
    },
    wait: false,
    scalable: {default: 0},
    envs: {
      // if you're setting it in a .env file
      MIX_ENV: "test",
      IEX_VERSION_PATTERN: pattern,
    },
  },
});

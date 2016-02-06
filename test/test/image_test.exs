defmodule ImageTest do
  use ExUnit.Case

  test "should iex version" do
    pattern = System.get_env("IEX_VERSION_PATTERN") |> Regex.compile!
    assert Regex.match?(pattern, System.version)
  end
end

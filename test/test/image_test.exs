defmodule ImageTest do
  use ExUnit.Case

  test "should iex version" do
    assert System.version == System.get_env("IEX_VERSION")
  end
end

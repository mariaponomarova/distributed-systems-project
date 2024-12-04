defmodule QuizzlerTest do
  use ExUnit.Case
  doctest Quizzler

  test "greets the world" do
    assert Quizzler.hello() == :world
  end
end

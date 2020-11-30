defmodule Islands.Board.CacheTest do
  use ExUnit.Case, async: true

  alias Islands.Board.Cache

  doctest Cache, only: TestHelper.doctest(Cache)

  @tag :islands_board_cache_test_1
  TestHelper.config_level(__MODULE__)

  test "the truth" do
    assert 1 + 2 == 3
  end

  Logger.configure(level: :all)
end

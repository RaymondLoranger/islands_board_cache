defmodule Islands.Board.CacheTest do
  use ExUnit.Case, async: true

  alias Islands.Board.Cache

  doctest Cache, only: TestHelper.doctests(Cache)

  @tag :islands_board_cache_test_1
  test "the truth" do
    assert 1 + 2 == 3
  end
end

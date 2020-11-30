defmodule Islands.Board.Cache.LoaderTest do
  use ExUnit.Case, async: true

  alias Islands.Board.Cache.Loader
  alias Islands.Board

  doctest Loader

  describe "Loader.read_boards/0" do
    @tag :islands_board_cache_loader_test_1
    TestHelper.config_level(__MODULE__)

    test "returns a list of boards" do
      boards = Loader.read_boards()
      assert is_list(boards)
      assert Enum.all?(boards, &is_struct(&1, Board))
    end

    Logger.configure(level: :all)
  end
end

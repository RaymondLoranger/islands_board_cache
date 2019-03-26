defmodule Islands.Board.Cache.LoaderTest do
  use ExUnit.Case, async: true

  alias Islands.Board.Cache.Loader
  alias Islands.Board

  doctest Loader

  describe "Loader.read_boards/0" do
    test "returns a list of boards" do
      boards = Loader.read_boards()
      assert is_list(boards)
      assert Enum.all?(boards, &assert(%Board{} = &1))
    end
  end
end

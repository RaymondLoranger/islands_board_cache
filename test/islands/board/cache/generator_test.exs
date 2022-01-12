defmodule Islands.Board.Cache.GeneratorTest do
  use ExUnit.Case, async: true

  alias Islands.Board.Cache.Generator
  alias Islands.Board

  doctest Generator

  describe "Generator.gen_boards/0" do
    @tag :islands_board_cache_generator_test_1
    test "returns a list of boards" do
      boards = Generator.gen_boards()
      assert is_list(boards)
      assert Enum.all?(boards, &is_struct(&1, Board))
    end
  end
end

defmodule Islands.Board.Cache.Generator do
  @moduledoc """
  Generates a random list of boards.
  """

  use PersistConfig

  alias Islands.Board.Cache.Log
  alias Islands.{Board, Coord, Island}

  @goal get_env(:boards_required)
  @range 1..10
  @types [:atoll, :dot, :l_shape, :s_shape, :square]

  @doc """
  Generates a random list of boards.
  """
  @spec gen_boards :: [Board.t()]
  def gen_boards do
    :ok = Log.info(:generating_boards, {@goal, __ENV__})
    MapSet.new() |> gen_set(0, @goal) |> MapSet.to_list()
  end

  ## Private functions

  # Generates a set of random boards.
  @spec gen_set(MapSet.t(), non_neg_integer, pos_integer) :: MapSet.t(Board.t())
  defp gen_set(set, size, goal) when size == goal, do: set

  defp gen_set(set, _size, goal) do
    set = MapSet.put(set, gen_board())
    gen_set(set, MapSet.size(set), goal)
  end

  # Generates a random board.
  @spec gen_board :: Board.t()
  defp gen_board do
    Enum.reduce(@types, Board.new(), &gen_board(&2, &1))
  end

  # Position a new island on the board.
  @spec gen_board(Board.t(), Island.type()) :: Board.t()
  defp gen_board(board, type) do
    case Board.position_island(board, gen_island(type)) do
      %Board{} = board -> board
      {:error, _} -> gen_board(board, type)
    end
  end

  # Generates a randomly positioned island.
  @spec gen_island(Island.type()) :: Island.t()
  defp gen_island(type) do
    case Island.new(type, gen_origin()) do
      {:ok, island} -> island
      {:error, _} -> gen_island(type)
    end
  end

  # Generates a random coordinates struct.
  @spec gen_origin :: Coord.t()
  defp gen_origin do
    {:ok, origin} = Coord.new(Enum.random(@range), Enum.random(@range))
    origin
  end
end

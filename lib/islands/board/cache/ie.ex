defmodule Islands.Board.Cache.IE do
  @moduledoc false

  use PersistConfig

  alias Islands.{Board, Coord, Island}

  @goal 1..999
  @path get_env(:board_set_path)
  @range 1..10
  @types [:atoll, :dot, :l_shape, :s_shape, :square]

  # Example of an IEx session...
  #
  #   iex -S mix
  #
  #   use Islands.Board.Cache.IE
  #   Cache.board_count
  #   => change 'assets/board_set.binary'
  #   Cache.refresh
  #   Cache.board_count
  #   => see that the change is reflected

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      alias unquote(__MODULE__)
      alias Islands.Board.Cache.{Loader, Log, Server, TopSup, Writer}
      alias Islands.Board.Cache
      alias Islands.{Board, Coord, Island}
      :ok
    end
  end

  @doc """
  Writes an encoded set of `goal` random boards to the configured external file.
  """
  @spec write_board_set(pos_integer) :: :ok
  def write_board_set(goal) when is_integer(goal) and goal in @goal do
    :ok = File.write(@path, gen_set(goal) |> :erlang.term_to_binary())
  end

  @doc "Generates a set of `goal` random boards."
  @spec gen_set(pos_integer) :: MapSet.t(Board.t())
  def gen_set(goal) when is_integer(goal) and goal in @goal do
    MapSet.new() |> pair_with_size() |> gen_set(goal)
  end

  ## Private functions

  @spec gen_set({MapSet.t(), non_neg_integer}, pos_integer) ::
          MapSet.t(Board.t())
  defp gen_set({set, size}, goal) when size >= goal, do: set

  defp gen_set({set, _size}, goal) do
    MapSet.put(set, gen_board()) |> pair_with_size() |> gen_set(goal)
  end

  # Pairs a set with its size as a tuple.
  @spec pair_with_size(MapSet.t()) :: {MapSet.t(), non_neg_integer}
  defp pair_with_size(set), do: {set, MapSet.size(set)}

  # Generates a random board.
  @spec gen_board :: Board.t()
  defp gen_board do
    Enum.reduce(@types, Board.new(), &gen_board(&2, &1))
  end

  @spec gen_board(Board.t(), atom) :: Board.t()
  defp gen_board(board, type) do
    case Board.position_island(board, gen_island(type)) do
      %Board{} = board -> board
      {:error, _} -> gen_board(board, type)
    end
  end

  # Generates a randomly positioned island.
  @spec gen_island(atom) :: Island.t()
  defp gen_island(type) do
    case Island.new(type, gen_origin()) do
      {:ok, island} -> island
      {:error, _} -> gen_island(type)
    end
  end

  # Generates a random coordinate.
  @spec gen_origin :: Coord.t()
  defp gen_origin do
    {:ok, origin} = Coord.new(Enum.random(@range), Enum.random(@range))
    origin
  end
end

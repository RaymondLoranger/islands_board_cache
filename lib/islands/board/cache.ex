# ┌───────────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └───────────────────────────────────────────────────────────────────────┘
defmodule Islands.Board.Cache do
  @moduledoc """
  Board Cache for the _Game of Islands_. Returns a random board.

  ##### Inspired by the book [Functional Web Development](https://pragprog.com/titles/lhelph/functional-web-development-with-elixir-otp-and-phoenix/) by Lance Halvorsen.

  ##### But mostly inspired by the course [Multi-Player Bingo](https://pragmaticstudio.com/courses/unpacked-bingo) by Mike and Nicole Clark.
  """

  alias __MODULE__.Server
  alias Islands.Board

  @doc """
  Returns a random board.

  ## Examples

      iex> alias Islands.Board.Cache
      iex> alias Islands.Board
      iex> %Board{islands: islands, misses: misses} = Cache.get_board()
      iex> {map_size(islands), MapSet.size(misses)}
      {5, 0}
  """
  @spec get_board :: Board.t()
  def get_board, do: GenServer.call(Server, :get_board)

  @doc """
  Returns the number of boards in the cache.

  ## Examples

      iex> alias Islands.Board.Cache
      iex> Cache.board_count()
      99
  """
  @spec board_count :: pos_integer
  def board_count, do: GenServer.call(Server, :board_count)
end

# ┌───────────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └───────────────────────────────────────────────────────────────────────┘
defmodule Islands.Board.Cache do
  @moduledoc """
  Board Cache for the _Game of Islands_. Returns a random board.

  ##### Inspired by the book [Functional Web Development](https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix) by Lance Halvorsen.

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
  def get_board do
    GenServer.call(Server, :get_board)
  end

  @doc """
  Returns the number of boards in the cache.
  """
  @spec board_count :: pos_integer
  def board_count do
    GenServer.call(Server, :board_count)
  end

  @doc """
  Persists the given board to the configured external file.
  """
  @spec persist_board(Board.t()) :: :ok
  def persist_board(%Board{} = board) do
    GenServer.cast(Server, {:persist_board, board})
  end

  @doc """
  Refreshes the cache from the configured external file and resets the timer.
  """
  @spec refresh :: :refresh
  def refresh, do: send(Server, :refresh)
end

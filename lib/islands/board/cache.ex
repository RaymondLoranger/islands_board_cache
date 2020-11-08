# ┌───────────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └───────────────────────────────────────────────────────────────────────┘
defmodule Islands.Board.Cache do
  use PersistConfig

  @book_and_course_ref get_env(:book_and_course_ref)

  @moduledoc """
  Board Cache for the _Game of Islands_. Returns a random board.
  \n##### #{@book_and_course_ref}
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
  Persists the given board to the configured external source.
  """
  @spec persist_board(Board.t()) :: :ok
  def persist_board(%Board{} = board) do
    GenServer.cast(Server, {:persist_board, board})
  end

  @doc """
  Refreshes the cache from the configured external source and resets the timer.
  """
  @spec refresh :: :refresh
  def refresh, do: send(Server, :refresh)
end

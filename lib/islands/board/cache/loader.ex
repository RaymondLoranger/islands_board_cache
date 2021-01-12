defmodule Islands.Board.Cache.Loader do
  @moduledoc """
  Reads the configured external file encoding a set of boards.
  Re-creates the set and turns it into a list of boards.
  """

  use PersistConfig

  alias Islands.Board.Cache.Log
  alias Islands.Board

  @boards get_env(:default_boards)
  @path get_env(:board_set_path)

  @doc """
  Reads the configured external file encoding a set of boards.
  Re-creates the set and turns it into a list of boards.
  """
  @spec read_boards :: [Board.t()]
  def read_boards do
    with {:ok, binary} <- File.read(@path),
         [_ | _] = boards <-
           :erlang.binary_to_term(binary) |> MapSet.to_list() do
      :ok = Log.info(:boards_read, {@path, boards, __ENV__})
      boards
    else
      {:error, reason} ->
        :ok = Log.error(:read_error, {@path, reason, @boards, __ENV__})
        @boards

      [] ->
        :ok = Log.error(:empty_set, {@path, @boards, __ENV__})
        @boards
    end
  end
end

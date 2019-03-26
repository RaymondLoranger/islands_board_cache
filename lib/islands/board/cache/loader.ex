defmodule Islands.Board.Cache.Loader do
  @moduledoc """
  Reads a binary file encoding a set of boards.
  Re-creates the set and converts it to a list.
  """

  use PersistConfig

  alias Islands.Board.Cache.Log
  alias Islands.Board

  @boards Application.get_env(@app, :default_boards).()
  @path Application.get_env(@app, :board_set_path)

  @doc """
  Reads a binary file encoding a set of boards.
  Re-creates the set and converts it to a list.
  """
  @dialyzer {:nowarn_function, read_boards: 0}
  @spec read_boards :: [Board.t()]
  def read_boards do
    try do
      with {:ok, binary} <- File.read(@path),
           %MapSet{} = set <- :erlang.binary_to_term(binary),
           [_ | _] = boards <- MapSet.to_list(set) do
        :ok = Log.info(:boards_read, {@path, boards})
        boards
      else
        {:error, reason} ->
          :ok = Log.warn(:read_error, {@path, reason, @boards})
          @boards

        [] ->
          :ok = Log.warn(:empty_list, {@path, @boards})
          @boards
      end
    rescue
      ArgumentError ->
        :ok = Log.warn(:invalid_binary, {@path, @boards})
        @boards

      WithClauseError ->
        :ok = Log.warn(:binary_not_a_set, {@path, @boards})
        @boards

      exception ->
        :ok = Log.warn(:exception, {@path, exception, @boards})
        @boards
    end
  end
end

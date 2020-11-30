defmodule Islands.Board.Cache.Writer do
  @moduledoc """
  Persists a board to the configured external file.
  """

  use PersistConfig

  alias Islands.Board.Cache.Log
  alias Islands.Board

  @path get_env(:board_set_path)

  @doc """
  Persists `board` to the configured external file.
  """
  @spec persist(Board.t()) :: :ok
  def persist(board) do
    with {:ok, binary} <- File.read(@path),
         set = binary |> :erlang.binary_to_term() |> MapSet.put(board),
         binary = :erlang.term_to_binary(set),
         :ok <- File.write(@path, binary) do
      :ok = Log.info(:board_persisted, {@path, __ENV__})
    else
      {:error, reason} ->
        :ok = Log.error(:error_persisting_board, {@path, reason, __ENV__})
    end
  end
end

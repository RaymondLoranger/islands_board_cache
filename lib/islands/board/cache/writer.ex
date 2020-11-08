defmodule Islands.Board.Cache.Writer do
  @moduledoc """
  Persists a given board to the configured external source.
  """

  use PersistConfig

  alias Islands.Board.Cache.Log
  alias Islands.Board

  @path get_env(:board_set_path)

  @doc """
  Persists `board` to the configured external source.
  """
  @spec persist(Board.t()) :: :ok
  def persist(board) do
    binary =
      case File.read(@path) do
        {:ok, binary} ->
          :erlang.binary_to_term(binary)

        {:error, reason} ->
          :ok = Log.warn(:read_error_while_persisting_board, {@path, reason})
          MapSet.new()
      end
      |> MapSet.put(board)
      |> :erlang.term_to_binary()

    case File.write(@path, binary) do
      :ok ->
        :ok = Log.info(:board_persisted, {@path, board})

      {:error, reason} ->
        :ok = Log.warn(:write_error_while_persisting_board, {@path, reason})
    end
  end
end

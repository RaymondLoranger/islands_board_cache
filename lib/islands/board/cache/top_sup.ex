defmodule Islands.Board.Cache.TopSup do
  @moduledoc false

  use Application

  alias __MODULE__
  alias Islands.Board.Cache.Server

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    [
      # Child spec relying on `use GenServer`...
      {Server, :ok}
    ]
    |> Supervisor.start_link(name: TopSup, strategy: :one_for_one)
  end
end
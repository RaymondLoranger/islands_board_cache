defmodule Islands.Board.Cache.Server do
  @moduledoc """
  Process that generates a list of `boards` and caches it for expedient access.
  """

  use GenServer
  use PersistConfig

  alias __MODULE__
  alias Islands.Board.Cache.Generator
  alias Islands.Board

  @timeout get_env(:timeout)

  @type from :: GenServer.from()
  @type state :: [Board.t()]

  @spec start_link(term) :: GenServer.on_start()
  def start_link(:ok), do: GenServer.start_link(Server, :ok, name: Server)

  ## Callbacks

  @spec init(term) :: {:ok, state, timeout}
  def init(:ok), do: {:ok, Generator.gen_boards(), @timeout}

  @spec handle_call(atom, from, state) :: {:reply, term, state, timeout}
  def handle_call(:get_board, _from, boards) do
    {:reply, Enum.random(boards), boards, @timeout}
  end

  def handle_call(:board_count, _from, boards) do
    {:reply, length(boards), boards, @timeout}
  end
end

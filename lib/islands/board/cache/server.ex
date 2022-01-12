defmodule Islands.Board.Cache.Server do
  @moduledoc """
  Process that generates a list of boards and caches it for expedient access.
  """

  use GenServer
  use PersistConfig

  alias __MODULE__
  alias Islands.Board.Cache.Generator
  alias Islands.Board

  @timeout :infinity

  @typedoc "Server state"
  @type state :: [Board.t()]

  @doc """
  Spawns a cache server process registered with the module name.
  """
  @spec start_link(term) :: GenServer.on_start()
  def start_link(:ok = _init_arg),
    do: GenServer.start_link(Server, :ok, name: Server)

  ## Callbacks

  @spec init(term) :: {:ok, state, timeout}
  def init(:ok = _init_arg), do: {:ok, Generator.gen_boards(), @timeout}

  @spec handle_call(atom, GenServer.from(), state) ::
          {:reply, Board.t(), state, timeout}
  def handle_call(:get_board, _from, boards) do
    {:reply, Enum.random(boards), boards, @timeout}
  end

  def handle_call(:board_count, _from, boards) do
    {:reply, length(boards), boards, @timeout}
  end

  @spec handle_info(term, state) :: {:noreply, state}
  def handle_info(_message, state), do: {:noreply, state}
end

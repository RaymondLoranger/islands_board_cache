defmodule Islands.Board.Cache.Server do
  @moduledoc """
  A process that loads a list of `boards` from an external file
  and caches it for expedient access. The cache is automatically
  refreshed every 10 minutes.
  """

  use GenServer
  use PersistConfig

  alias __MODULE__
  alias Islands.Board.Cache.{Loader, Writer}
  alias Islands.Board

  @refresh_interval get_env(:refresh_interval)
  @timeout get_env(:timeout)

  @type from :: GenServer.from()
  @type state :: {[Board.t()], reference}

  @spec start_link(term) :: GenServer.on_start()
  def start_link(:ok), do: GenServer.start_link(Server, :ok, name: Server)

  ## Private functions

  @spec schedule_refresh :: reference
  defp schedule_refresh,
    do: self() |> Process.send_after(:refresh, @refresh_interval)

  ## Callbacks

  @spec init(term) :: {:ok, state, timeout}
  def init(:ok), do: {:ok, {Loader.read_boards(), schedule_refresh()}, @timeout}

  @spec handle_call(atom, from, state) :: {:reply, term, state, timeout}
  def handle_call(:get_board, _from, {boards, _timer_ref} = state) do
    {:reply, Enum.random(boards), state, @timeout}
  end

  def handle_call(:board_count, _from, {boards, _timer_ref} = state) do
    {:reply, length(boards), state, @timeout}
  end

  @spec handle_cast(tuple, state) :: {:noreply, state, timeout}
  def handle_cast({:persist_board, board}, state) do
    :ok = Writer.persist(board)
    {:noreply, state, @timeout}
  end

  @spec handle_info(term, state) :: {:noreply, state, timeout}
  def handle_info(:refresh, {_boards, timer_ref} = _state) do
    Process.cancel_timer(timer_ref, info: false)
    {:noreply, {Loader.read_boards(), schedule_refresh()}, @timeout}
  end

  def handle_info(_message, state), do: {:noreply, state, @timeout}
end

defmodule Islands.Board.Cache.Server do
  @moduledoc """
  A process that loads a list of boards from an external source
  and caches it for expedient access. The cache is automatically
  refreshed every 10 minutes.
  """

  use GenServer
  use PersistConfig

  alias __MODULE__
  alias Islands.Board.Cache.{Loader, Log}
  alias Islands.Board

  @path Application.get_env(@app, :board_set_path)
  @refresh_interval :timer.minutes(10)

  @type from :: GenServer.from()
  @type state :: {[Board.t()], reference}

  @spec start_link(term) :: GenServer.on_start()
  def start_link(:ok), do: GenServer.start_link(Server, :ok, name: Server)

  ## Private functions

  @spec schedule_refresh :: reference
  defp schedule_refresh,
    do: self() |> Process.send_after(:refresh, @refresh_interval)

  ## Callbacks

  @spec init(term) :: {:ok, state}
  def init(:ok), do: {:ok, {Loader.read_boards(), schedule_refresh()}}

  @spec handle_call(atom, from, state) :: {:reply, term, state}
  def handle_call(:get_board, _from, {boards, _timer_ref} = state) do
    {:reply, Enum.random(boards), state}
  end

  def handle_call(:board_count, _from, {boards, _timer_ref} = state) do
    {:reply, length(boards), state}
  end

  @spec handle_cast(tuple, state) :: {:noreply, state}
  def handle_cast({:persist_board, board}, state) do
    File.write(
      @path,
      case File.read(@path) do
        {:ok, binary} -> :erlang.binary_to_term(binary)
        {:error, _reason} -> MapSet.new()
      end
      |> MapSet.put(board)
      |> :erlang.term_to_binary()
    )

    :ok = Log.info(:board_persisted, {@path, board})
    {:noreply, state}
  end

  @spec handle_info(term, state) :: {:noreply, state}
  def handle_info(:refresh, {_boards, timer_ref} = _state) do
    Process.cancel_timer(timer_ref, info: false)
    {:noreply, {Loader.read_boards(), schedule_refresh()}}
  end
end

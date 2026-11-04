defmodule Islands.Board.Cache.Server do
  @moduledoc """
  Process that generates a list of boards and caches it for expedient access.
  Can be made to time out after a period of inactivity.
  """

  use GenServer, restart: :transient
  use PersistConfig

  alias __MODULE__
  alias Islands.Board.Cache.{Generator, Log}
  alias Islands.Board

  @timeout :infinity
  # @timeout :timer.minutes(30)
  # @timeout :timer.seconds(30)
  # @wait 100

  @typedoc "Server state"
  @type state :: [Board.t()]

  @doc """
  Spawns a cache server process registered with the module name.
  """
  @spec start_link(term) :: GenServer.on_start()
  def start_link(_init_arg = :ok),
    do: GenServer.start_link(Server, :ok, name: Server)

  ## Callbacks

  @spec init(term) :: {:ok, state, timeout}
  def init(_init_arg = :ok), do: {:ok, Generator.gen_boards(), @timeout}

  @spec handle_call(atom, GenServer.from(), state) ::
          {:reply, Board.t(), state, timeout}
  def handle_call(:get_board, _from, boards) do
    {:reply, Enum.random(boards), boards, @timeout}
  end

  def handle_call(:board_count, _from, boards) do
    {:reply, length(boards), boards, @timeout}
  end

  @spec handle_info(term, state) ::
          {:stop, reason :: tuple, state} | {:noreply, state}
  def handle_info(:timeout, state), do: {:stop, {:shutdown, :timeout}, state}
  def handle_info(_message, state), do: {:noreply, state}

  @spec terminate(term, state) :: :ok
  def terminate(reason, state)
      when reason in [:shutdown, {:shutdown, :timeout}] do
    :ok = Log.info(:terminating, {reason, state, __ENV__})
    # Ensure message logged before exiting...
    # Process.sleep(@wait)
  end

  def terminate(reason, state) do
    :ok = Log.error(:terminating, {reason, state, __ENV__})
    # Ensure message logged before exiting...
    # Process.sleep(@wait)
  end
end

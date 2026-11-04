defmodule Islands.Board.Cache.Log do
  use File.Only.Logger

  info :generating_boards, {goal, env} do
    {:registered_name, name} = self() |> Process.info(:registered_name)

    """
    \nGenerating a list of random boards...
    • Server: #{inspect(name) |> maybe_break(10)}
    • Server PID: #{self() |> inspect()}
    • Boards required: #{goal}
    #{from(env, __MODULE__)}\
    """
  end

  error :terminating, {reason, state, env} do
    {:registered_name, name} = self() |> Process.info(:registered_name)

    """
    \nTerminating board cache...
    • Server: #{inspect(name) |> maybe_break(10)}
    • Server PID: #{self() |> inspect()}
    • Boards cached: #{length(state)}
    • 'terminate' reason: #{inspect(reason) |> maybe_break(22)}
    #{from(env, __MODULE__)}\
    """
  end

  info :terminating, {reason, state, env} do
    {:registered_name, name} = self() |> Process.info(:registered_name)

    """
    \nTerminating board cache...
    • Server: #{inspect(name) |> maybe_break(10)}
    • Server PID: #{self() |> inspect()}
    • Boards cached: #{length(state)}
    • 'terminate' reason: #{inspect(reason) |> maybe_break(22)}
    #{from(env, __MODULE__)}\
    """
  end
end

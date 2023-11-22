defmodule Islands.Board.Cache.Log do
  use File.Only.Logger

  info :generating_boards, {goal, env} do
    """
    \nGenerating a list of random boards...
    • Number of boards required: #{goal}
    #{from(env, __MODULE__)}\
    """
  end
end

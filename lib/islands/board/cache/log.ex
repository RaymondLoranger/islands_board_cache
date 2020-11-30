defmodule Islands.Board.Cache.Log do
  use File.Only.Logger

  info :boards_read, {path, boards, env} do
    """
    \nBoards read from external file...
    • Inside function:
      #{fun(env)}
    • File:
      #{path}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  error :read_error, {path, reason, boards, env} do
    """
    \nError reading external file...
    • Inside function:
      #{fun(env)}
    • File:
      #{path}
    • Error:
      #{reason |> :file.format_error() |> inspect()}
    • Default boards used:
      #{inspect(boards)}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  error :empty_set, {path, boards, env} do
    """
    \nEmpty set encoded in external file...
    • Inside function:
      #{fun(env)}
    • File:
      #{path}
    • Default boards used:
      #{inspect(boards)}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  info :board_persisted, {path, env} do
    """
    \nBoard persisted to external file...
    • Inside function:
      #{fun(env)}
    • File:
      #{path}
    #{from()}
    """
  end

  error :error_persisting_board, {path, reason, env} do
    """
    \nError persisting board to external file...
    • Inside function:
      #{fun(env)}
    • File:
      #{path}
    • Error:
      #{reason |> :file.format_error() |> inspect()}
    #{from()}
    """
  end
end

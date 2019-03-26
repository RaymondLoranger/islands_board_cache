defmodule Islands.Board.Cache.Log do
  use File.Only.Logger

  info :boards_read, {path, boards} do
    """
    \nBoards read from external source...
    • File:
      #{path}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  warn :read_error, {path, reason, boards} do
    """
    \nIssue encountered reading external source...
    • File:
      #{path}
    • Issue:
      #{reason |> :file.format_error() |> inspect()}
    • Default boards used:
      #{inspect(boards)}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  warn :empty_list, {path, boards} do
    """
    \nEmpty list of boards read from external source...
    • File:
      #{path}
    • Issue:
      'empty list'
    • Default boards used:
      #{inspect(boards)}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  warn :invalid_binary, {path, boards} do
    """
    \nInvalid binary encoded in external source...
    • File:
      #{path}
    • Issue:
      'invalid binary'
    • Default boards used:
      #{inspect(boards)}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  warn :binary_not_a_set, {path, boards} do
    """
    \nBinary encoded in external source not a set...
    • File:
      #{path}
    • Issue:
      'binary not a set'
    • Default boards used:
      #{inspect(boards)}
    • Board count: #{length(boards)}
    #{from()}
    """
  end

  warn :exception, {path, exception, boards} do
    """
    \nException encountered reading external source...
    • File:
      #{path}
    • Exception:
      #{inspect(exception)}
    • Default boards used:
      #{inspect(boards)}
    • Board count: #{length(boards)}
    #{from()}
    """
  end
end

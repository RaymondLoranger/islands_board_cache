use Mix.Config

config :islands_board_cache,
  course_ref:
    """
    Inspired by the course [Multi-Player Bingo]
    (https://pragmaticstudio.com/courses/unpacked-bingo)\s
    by Mike and Nicole Clark.
    """
    |> String.replace("\n", "")

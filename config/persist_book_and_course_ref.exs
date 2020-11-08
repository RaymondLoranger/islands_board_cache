import Config

config :islands_board_cache,
  book_ref:
    """
    Inspired by the book [Functional Web Development]
    (https://pragprog.com/book/lhelph/functional-web-development-
    with-elixir-otp-and-phoenix) by Lance Halvorsen.
    """
    |> String.replace("\n", "")

config :islands_board_cache,
  course_ref:
    """
    Also inspired by the course [Multi-Player Bingo]
    (https://pragmaticstudio.com/courses/unpacked-bingo)\s
    by Mike and Nicole Clark.
    """
    |> String.replace("\n", "")

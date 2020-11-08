import Config

config :islands_board_cache,
  course_elixir_for_programmers:
    """
    course [Elixir for Programmers]
    (https://codestool.coding-gnome.com/courses/
    elixir-for-programmers) by Dave Thomas
    """
    |> String.replace("\n", ""),
  book_functional_web_development:
    """
    book [Functional Web Development]
    (https://pragprog.com/book/lhelph/functional-web-development-
    with-elixir-otp-and-phoenix) by Lance Halvorsen
    """
    |> String.replace("\n", ""),
  course_multi_player_bingo:
    """
    course [Multi-Player Bingo]
    (https://pragmaticstudio.com/courses/unpacked-bingo)\s
    by Mike and Nicole Clark
    """
    |> String.replace("\n", "")

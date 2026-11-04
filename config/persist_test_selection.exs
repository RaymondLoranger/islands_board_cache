import Config

# Allows to run the doctest(s) of one or a few functions at a time...
config :islands_board_cache,
  doctests: %{
    Islands.Board.Cache => [
      get_board: 0,
      board_count: 0,
    ],
  }

# Allows to run one or a few tests at a time...
config :islands_board_cache,
  excluded_tags: [
    # :islands_board_cache_test_1,
    # :islands_board_cache_generator_test_1,
    # :islands_board_cache_server_test_1,
  ]

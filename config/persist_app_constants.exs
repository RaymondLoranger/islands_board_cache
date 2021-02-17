import Config

config :islands_board_cache, timeout: :infinity
config :islands_board_cache, refresh_interval: :timer.minutes(30)

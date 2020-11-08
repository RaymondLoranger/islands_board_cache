import Config

# Mix messages in colors...
# config :elixir, ansi_enabled: true

import_config "config_logger.exs"
import_config "#{Mix.env()}.exs"

import_config "persist_board_set_path.exs"
import_config "persist_default_boards.exs"

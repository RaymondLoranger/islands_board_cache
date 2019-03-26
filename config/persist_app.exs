use Mix.Config

config :islands_board_cache, board_range: 1..10

config :islands_board_cache,
  board_set_path: "#{File.cwd!()}/assets/board_set.binary"

config :islands_board_cache,
  default_boards: fn ->
    alias Islands.{Board, Coord, Island}

    {:ok, atoll} = Coord.new(1, 5)
    {:ok, atoll} = Island.new(:atoll, atoll)
    {:ok, dot} = Coord.new(1, 4)
    {:ok, dot} = Island.new(:dot, dot)
    {:ok, l_shape} = Coord.new(1, 1)
    {:ok, l_shape} = Island.new(:l_shape, l_shape)
    {:ok, s_shape} = Coord.new(2, 3)
    {:ok, s_shape} = Island.new(:s_shape, s_shape)
    {:ok, square} = Coord.new(1, 2)
    {:ok, square} = Island.new(:square, square)

    [
      Board.new()
      |> Board.position_island(atoll)
      |> Board.position_island(dot)
      |> Board.position_island(l_shape)
      |> Board.position_island(s_shape)
      |> Board.position_island(square)
    ]
  end

config :islands_board_cache,
  island_types: [:atoll, :dot, :l_shape, :s_shape, :square]

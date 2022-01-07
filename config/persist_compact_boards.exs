import Config

alias Islands.{Board, Coord, Island}

# Islands compactly occupying first 3 rows over 6 columns...
config :islands_board_cache,
  compact_boards: [
    # Leftmost 6 columns..
    Board.new()
    |> Board.position_island(Island.new!(:atoll, Coord.new!(1, 5)))
    |> Board.position_island(Island.new!(:dot, Coord.new!(1, 4)))
    |> Board.position_island(Island.new!(:l_shape, Coord.new!(1, 1)))
    |> Board.position_island(Island.new!(:s_shape, Coord.new!(2, 3)))
    |> Board.position_island(Island.new!(:square, Coord.new!(1, 2))),
    # Rightmost 6 columns..
    Board.new()
    |> Board.position_island(Island.new!(:atoll, Coord.new!(1, 9)))
    |> Board.position_island(Island.new!(:dot, Coord.new!(1, 8)))
    |> Board.position_island(Island.new!(:l_shape, Coord.new!(1, 5)))
    |> Board.position_island(Island.new!(:s_shape, Coord.new!(2, 7)))
    |> Board.position_island(Island.new!(:square, Coord.new!(1, 6)))
  ]

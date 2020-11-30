import Config

alias Islands.{Board, Coord, Island}

# Islands compactly occupying first 3 rows and 6 columns...
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

config :islands_board_cache,
  default_boards: [
    Board.new()
    |> Board.position_island(atoll)
    |> Board.position_island(dot)
    |> Board.position_island(l_shape)
    |> Board.position_island(s_shape)
    |> Board.position_island(square)
  ]

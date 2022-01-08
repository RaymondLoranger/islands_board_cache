import Config

alias Islands.{Board, Coord, Island}

# Origins of clusters...
clusters = [
  top_left: {1, 1},
  top_right: {1, 5},
  bottom_left: {8, 1},
  bottom_right: {8, 5}
]

# Offsets of islands clustered in an area of 3 rows by 6 columns...
islands = [
  atoll: {0, 4},
  dot: {0, 3},
  l_shape: {0, 0},
  s_shape: {1, 2},
  square: {0, 1}
]

dense_boards =
  for {_desc, {row, col}} <- clusters do
    for {type, {row_offset, col_offset}} <- islands do
      {:ok, origin} = Coord.new(row + row_offset, col + col_offset)
      {:ok, island} = Island.new(type, origin)
      island
    end
    |> Enum.reduce(Board.new(), &Board.position_island(&2, &1))
  end

config :islands_board_cache, dense_boards: dense_boards

# Top-left, bottom-right, bottom-left and top-right clusters...
#
#    1 2 3 4 5 6 7 8 9 0          1 2 3 4 5 6 7 8 9 0
#  ┌─────────────────────┐      ┌─────────────────────┐
# 1│ l q q d a a . . . . │1    1│ . . . . l q q d a a │1
# 2│ l q q s s a . . . . │2    2│ . . . . l q q s s a │2
# 3│ l l s s a a . . . . │3    3│ . . . . l l s s a a │3
# 4│ . . . . . . . . . . │4    4│ . . . . . . . . . . │4
# 5│ . . . . . . . . . . │5    5│ . . . . . . . . . . │5
# 6│ . . . . . . . . . . │6    6│ . . . . . . . . . . │6
# 7│ . . . . . . . . . . │7    7│ . . . . . . . . . . │7
# 8│ . . . . l q q d a a │8    8│ l q q d a a . . . . │8
# 9│ . . . . l q q s s a │9    9│ l q q s s a . . . . │9
# 0│ . . . . l l s s a a │0    0│ l l s s a a . . . . │0
#  └─────────────────────┘      └─────────────────────┘
#    1 2 3 4 5 6 7 8 9 0          1 2 3 4 5 6 7 8 9 0

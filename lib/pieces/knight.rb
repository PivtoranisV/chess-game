# frozen_string_literal: true

require_relative 'pieces'

class Knight < Pieces
  def possible_moves(_board = nil)
    position_x, position_y = position

    moves = [
      [position_x + 2, position_y + 1], [position_x + 2, position_y - 1],
      [position_x - 2, position_y + 1], [position_x - 2, position_y - 1],
      [position_x + 1, position_y + 2], [position_x + 1, position_y - 2],
      [position_x - 1, position_y + 2], [position_x - 1, position_y - 2]
    ]
    # Return moves only within the 8x8 board
    valid_moves(moves)
  end
end

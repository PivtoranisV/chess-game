# frozen_string_literal: true

require_relative 'pieces'

class King < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265A" : "\u2654", color)
  end

  def possible_moves
    position_x, position_y = position

    moves = [
      [position_x + 1, position_y], [position_x - 1, position_y],
      [position_x, position_y + 1], [position_x, position_y - 1],
      [position_x + 1, position_y + 1], [position_x + 1, position_y - 1],
      [position_x - 1, position_y + 1], [position_x - 1, position_y - 1]
    ]

    # Return moves only within the 8x8 board
    valid_move(moves)
  end
end

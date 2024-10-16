# frozen_string_literal: true

require_relative 'pieces'

class Knight < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265E" : "\u2658", color)
  end

  def possible_moves
    start_position_x, start_position_y = position

    moves = [
      [start_position_x + 2, start_position_y + 1], [start_position_x + 2, start_position_y - 1],
      [start_position_x - 2, start_position_y + 1], [start_position_x - 2, start_position_y - 1],
      [start_position_x + 1, start_position_y + 2], [start_position_x + 1, start_position_y - 2],
      [start_position_x - 1, start_position_y + 2], [start_position_x - 1, start_position_y - 2]
    ]
    # Return moves only within the 8x8 board
    valid_move(moves)
  end
end

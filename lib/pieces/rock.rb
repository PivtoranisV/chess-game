# frozen_string_literal: true

require_relative 'pieces'

class Rock < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265C" : "\u2656", color)
  end

  def possible_moves
    start_position_x, start_position_y = position

    moves = [
      [start_position_x + 1, start_position_y], [start_position_x + 2, start_position_y],
      [start_position_x + 3, start_position_y], [start_position_x + 4, start_position_y],
      [start_position_x + 5, start_position_y], [start_position_x + 6, start_position_y],
      [start_position_x + 7, start_position_y], [start_position_x - 1, start_position_y],
      [start_position_x - 2, start_position_y], [start_position_x - 3, start_position_y],
      [start_position_x - 4, start_position_y], [start_position_x - 5, start_position_y],
      [start_position_x - 6, start_position_y], [start_position_x - 7, start_position_y],
      [start_position_x, start_position_y + 1], [start_position_x, start_position_y + 2],
      [start_position_x, start_position_y + 3], [start_position_x, start_position_y + 4],
      [start_position_x, start_position_y + 5], [start_position_x, start_position_y + 6],
      [start_position_x, start_position_y + 7], [start_position_x, start_position_y - 1],
      [start_position_x, start_position_y - 2], [start_position_x, start_position_y - 3],
      [start_position_x, start_position_y - 4], [start_position_x, start_position_y - 5],
      [start_position_x, start_position_y - 6], [start_position_x, start_position_y - 7]
    ]
    # Return moves only within the 8x8 board
    valid_move(moves)
  end
end

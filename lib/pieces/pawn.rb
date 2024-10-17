# frozen_string_literal: true

require_relative 'pieces'

class Pawn < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265F" : "\u2659", color)
  end

  def possible_moves
    start_position_x, start_position_y = position
    moves = []

    # Move direction depends on color
    direction = color == :black ? 1 : -1

    # Regular move (one square forward)
    regular_move = [start_position_x + direction, start_position_y]
    moves << regular_move

    # First move (two squares forward)
    if (color == :white && start_position_x == 6) || (color == :black && start_position_x == 1)
      first_move = [start_position_x + 2 * direction, start_position_y]
      moves << first_move
    end

    # Return moves only within the 8x8 board
    valid_moves(moves)
  end
end

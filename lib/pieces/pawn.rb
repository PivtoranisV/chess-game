# frozen_string_literal: true

require_relative 'pieces'

class Pawn < Pieces
  def possible_moves(board)
    start_position_x, start_position_y = position
    moves = []

    # Move direction depends on color
    direction = color == :black ? -1 : 1

    # Regular move (one square forward)
    regular_move = [start_position_x + direction, start_position_y]
    moves << regular_move if valid_move?(regular_move) && !board.square_occupied?(regular_move)

    # First move (two squares forward)
    if (color == :black && start_position_x == 6) || (color == :white && start_position_x == 1)
      one_step_forward = [start_position_x + direction, start_position_y]
      first_move = [start_position_x + 2 * direction, start_position_y]

      # Check that both one step and two steps forward are not blocked
      if valid_move?(first_move) && !board.square_occupied?(one_step_forward) && !board.square_occupied?(first_move)
        moves << first_move
      end
    end

    # Capture moves
    capture_moves = [
      [start_position_x + direction, start_position_y + 1],
      [start_position_x + direction, start_position_y - 1]
    ]
    capture_moves.each do |capture_move|
      piece = board.square_occupied?(capture_move)
      moves << capture_move if valid_move?(capture_move) && piece && piece.color != color
    end

    moves
  end
end

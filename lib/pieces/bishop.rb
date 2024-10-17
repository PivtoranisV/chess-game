# frozen_string_literal: true

require_relative 'pieces'

class Bishop < Pieces
  def possible_moves(board)
    directions = [[1, 1], [-1, -1], [1, -1], [-1, 1]]

    possible_moves_by_direction(board, position, directions)
  end
end

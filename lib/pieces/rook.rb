# frozen_string_literal: true

require_relative 'pieces'

class Rook < Pieces
  def possible_moves(board)
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

    possible_moves_by_direction(board, position, directions)
  end
end

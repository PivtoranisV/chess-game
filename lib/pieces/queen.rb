# frozen_string_literal: true

require_relative 'pieces'

class Queen < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265B" : "\u2655", color)
  end

  def possible_moves(board)
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [-1, -1], [1, -1], [-1, 1]]

    possible_moves_by_direction(board, position, directions)
  end
end

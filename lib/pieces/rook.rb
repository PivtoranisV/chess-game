# frozen_string_literal: true

require_relative 'pieces'

class Rook < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265C" : "\u2656", color)
  end

  def possible_moves(board)
    position_x, position_y = position
    moves = []
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

    directions.each do |direction|
      (1..7).each do |move|
        new_pos = [position_x + move * direction[0], position_y + move * direction[1]]
        break if !valid_move?(new_pos) || add_moves(moves, new_pos, board)
      end
    end
    moves
  end
end

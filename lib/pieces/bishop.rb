# frozen_string_literal: true

require_relative 'pieces'

class Bishop < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265D" : "\u2657", color)
  end

  def possible_moves
    position_x, position_y = position
    moves = []
    7.downto(1) { |move| moves << [position_x + move, position_y + move] }
    7.downto(1) { |move| moves << [position_x - move, position_y - move] }
    7.downto(1) { |move| moves << [position_x + move, position_y - move] }
    7.downto(1) { |move| moves << [position_x - move, position_y + move] }
    # Return moves only within the 8x8 board
    valid_move(moves)
  end
end

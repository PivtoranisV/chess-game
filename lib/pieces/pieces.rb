# frozen_string_literal: true

class Pieces
  attr_accessor :position, :symbol, :color

  def initialize(position, symbol, color)
    @position = position
    @symbol = symbol
    @color = color
  end

  def valid_move(possible_moves)
    possible_moves.select { |position_x, position_y| position_x.between?(0, 7) && position_y.between?(0, 7) }
  end

  def valid_move?(move)
    position_x, position_y = move
    position_x.between?(0, 7) && position_y.between?(0, 7)
  end
end

# frozen_string_literal: true

class Pieces
  attr_accessor :position, :symbol, :color

  def initialize(position, symbol, color)
    @position = position
    @symbol = symbol
    @color = color
  end
end

# frozen_string_literal: true

require_relative 'pieces'

class Knight < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265E" : "\u2658", color)
  end

  def possible_moves
    start_position_x, start_position_y = position
    move1 = [start_position_x + 2, start_position_y + 1]
    move2 = [start_position_x + 2, start_position_y - 1]
    move3 = [start_position_x - 2, start_position_y + 1]
    move4 = [start_position_x - 2, start_position_y - 1]
    move5 = [start_position_x + 1, start_position_y + 2]
    move6 = [start_position_x + 1, start_position_y - 2]
    move7 = [start_position_x - 1, start_position_y + 2]
    move8 = [start_position_x - 1, start_position_y - 2]

    # Return moves only within the 8x8 board
    [move1, move2, move3, move4, move5, move6, move7, move8].select do |(x, y)|
      x.between?(0, 7) && y.between?(0, 7)
    end
  end
end

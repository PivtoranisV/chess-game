# frozen_string_literal: true

class Pieces
  attr_accessor :position, :symbol, :color

  def initialize(position, symbol, color)
    @position = position
    @symbol = symbol
    @color = color
  end

  private

  def possible_moves_by_direction(board, position, directions)
    position_x, position_y = position
    moves = []
    directions.each do |direction|
      (1..7).each do |move|
        new_pos = [position_x + move * direction[0], position_y + move * direction[1]]
        break if !valid_move?(new_pos) || add_moves(moves, new_pos, board)
      end
    end
    moves
  end

  def valid_moves(possible_moves)
    possible_moves.select { |move| valid_move?(move) }
  end

  def valid_move?(move)
    position_x, position_y = move
    position_x.between?(0, 7) && position_y.between?(0, 7)
  end

  def add_moves(moves, new_pos, board)
    piece = board.square_occupied?(new_pos)
    return true if piece && piece.color == color # Blocked by own piece

    moves << new_pos

    piece.nil? ? false : true # Stop if occupied by an opponent's piece
  end
end

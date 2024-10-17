# frozen_string_literal: true

class Pieces
  attr_accessor :position, :symbol, :color

  def initialize(position, color)
    @position = position
    @symbol = set_symbol(color)
    @color = color
  end

  private

  def set_symbol(color)
    case self.class.name
    when 'Rook' then color == :black ? "\u265C" : "\u2656"
    when 'Knight' then color == :black ? "\u265E" : "\u2658"
    when 'Bishop' then color == :black ? "\u265D" : "\u2657"
    when 'Queen' then color == :black ? "\u265B" : "\u2655"
    when 'King' then color == :black ? "\u265A" : "\u2654"
    when 'Pawn' then color == :black ? "\u265F" : "\u2659"
    end
  end

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

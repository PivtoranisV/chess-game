# frozen_string_literal: true

require_relative 'pieces'

class Rook < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265C" : "\u2656", color)
  end

  def possible_moves(board)
    position_x, position_y = position
    moves = []

    (1..7).each do |move|
      new_pos = [position_x, position_y + move]
      break if !valid_move?(new_pos) || add_moves(moves, new_pos, board)
    end

    (1..7).each do |move|
      new_pos = [position_x, position_y - move]
      break if !valid_move?(new_pos) || add_moves(moves, new_pos, board)
    end

    (1..7).each do |move|
      new_pos = [position_x + move, position_y]

      break if !valid_move?(new_pos) || add_moves(moves, new_pos, board)
    end
    (1..7).each do |move|
      new_pos = [position_x - move, position_y]
      break if !valid_move?(new_pos) || add_moves(moves, new_pos, board)
    end

    moves
  end

  private

  def add_moves(moves, new_pos, board)
    piece = board.square_occupied?(new_pos)
    return true if piece && piece.color == color # Blocked by own piece

    moves << new_pos

    piece.nil? ? false : true # Stop if occupied by an opponent's piece
  end
end

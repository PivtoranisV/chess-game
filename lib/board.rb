# frozen_string_literal: true

require 'colorize'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
class Board
  attr_reader :grid

  def initialize
    @grid = create_grid
    populate_pieces
  end

  def square_occupied(position)
    position_x, position_y = position
    grid[position_x][position_y]
  end

  def update_board(positions)
    start_position, end_position = positions
    piece = square_occupied(start_position)

    grid[start_position[0]][start_position[1]] = nil
    grid[end_position[0]][end_position[1]] = piece
    piece.position = end_position
  end

  def king_in_check?(color)
    king_position = find_king_position(color)

    opponent_pieces = grid.flatten.compact.reject { |piece| piece.color == color }

    opponent_pieces.any? do |piece|
      piece.possible_moves(self).include?(king_position)
    end
  end

  def checkmate?(color)
    return false unless king_in_check?(color)

    player_pieces = grid.flatten.compact.select { |piece| piece.color == color }

    # Simulate moves
    player_pieces.each do |piece|
      piece.possible_moves(self).each do |move|
        # Temporarily make the move
        start_position = piece.position
        end_position = move
        captured_piece = square_occupied(end_position)

        update_board([start_position, end_position])

        # Check if the king is still in check after the move
        still_in_check = king_in_check?(color)

        # Undo the move
        update_board([end_position, start_position])
        grid[end_position[0]][end_position[1]] = captured_piece
        piece.position = start_position

        # If the king is not in check after any move, it's not checkmate
        return false unless still_in_check
      end
    end
    true
  end

  private

  def find_king_position(color)
    king = grid.flatten.compact.find { |piece| piece.instance_of?(King) && piece.color == color }
    king.position
  end

  def create_grid
    Array.new(8) { Array.new(8) }
  end

  def populate_pieces
    piece_positions = {
      black: { row1: [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook],
               row2: [Pawn] * 8 },
      white: { row1: [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook],
               row2: [Pawn] * 8 }
    }

    # Placing white pieces
    place_pieces(piece_positions[:white][:row1], 0, :white)
    place_pieces(piece_positions[:white][:row2], 1, :white)

    # Placing black pieces
    place_pieces(piece_positions[:black][:row1], 7, :black)
    place_pieces(piece_positions[:black][:row2], 6, :black)
  end

  def place_pieces(pieces, row, color)
    pieces.each_with_index do |piece_class, col|
      grid[row][col] = piece_class.new([row, col], color)
    end
  end
end

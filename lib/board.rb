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
  end

  private

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

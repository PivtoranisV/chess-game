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

  def display_board
    puts '    |  a  |  b  |  c  |  d  |  e  |  f  |  g  |  h  |'
    puts '----|-----|-----|-----|-----|-----|-----|-----|-----|----'

    grid.reverse.each_with_index do |row, row_index|
      formatted_row = row.map.with_index do |cell, col_index|
        cell_display = cell.nil? ? '   ' : " #{colorize_piece(cell)} "
        background_color = (row_index + col_index).even? ? :light_yellow : :light_blue
        cell_display.colorize(background: background_color)
      end.join(' | ')

      puts " #{8 - row_index}  | #{formatted_row} |  #{8 - row_index} "
      puts '____|_____|_____|_____|_____|_____|_____|_____|_____|____'
    end
    puts '    |  a  |  b  |  c  |  d  |  e  |  f  |  g  |  h  |'
  end

  def square_occupied?(position)
    position_x, position_y = position
    grid[position_x][position_y]
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

  def colorize_piece(piece)
    piece_color = piece.color == :black ? :black : :white
    piece.symbol.colorize(color: piece_color)
  end
end

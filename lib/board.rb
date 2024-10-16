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
    puts '|     |  a  |  b  |  c  |  d  |  e  |  f  |  g  |  h  |'
    puts '|-----|-----|-----|-----|-----|-----|-----|-----|-----|'

    grid.each_with_index do |row, row_index|
      formatted_row = row.map.with_index do |cell, col_index|
        cell_display = cell.nil? ? '   ' : " #{colorize_piece(cell)} "
        background_color = (row_index + col_index).even? ? :light_yellow : :light_blue
        cell_display.colorize(background: background_color)
      end.join(' | ')

      puts "|  #{row_index + 1}  | #{formatted_row} |"
      puts '|_____|_____|_____|_____|_____|_____|_____|_____|_____|'
    end
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

    # Placing black pieces
    place_pieces(piece_positions[:black][:row1], 0, :black)
    place_pieces(piece_positions[:black][:row2], 1, :black)

    # Placing white pieces
    place_pieces(piece_positions[:white][:row1], 7, :white)
    place_pieces(piece_positions[:white][:row2], 6, :white)
  end

  def place_pieces(pieces, row, color)
    pieces.each_with_index do |piece_class, col|
      grid[row][col] = piece_class.new([row, col], color).symbol
    end
  end

  def colorize_piece(piece_symbol)
    piece_color = piece_symbol =~ /\u265A|\u265B|\u265C|\u265D|\u265E|\u265F/ ? :black : :white
    piece_symbol.colorize(color: piece_color)
  end
end

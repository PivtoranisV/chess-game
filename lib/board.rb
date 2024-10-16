# frozen_string_literal: true

require 'colorize'
require_relative 'pieces/rock'
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
        cell_display = cell.nil? ? '   ' : " #{cell} "
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
    # Black pieces
    grid[0][0] = Rock.new([0, 0], "\u265C", 'Black').symbol
    grid[0][1] = Knight.new([0, 1], "\u265E", 'Black').symbol
    grid[0][2] = Bishop.new([0, 2], "\u265D", 'Black').symbol
    grid[0][3] = Queen.new([0, 3], "\u265B", 'Black').symbol
    grid[0][4] = King.new([0, 4], "\u265A", 'Black').symbol
    grid[0][5] = Bishop.new([0, 5], "\u265D", 'Black').symbol
    grid[0][6] = Knight.new([0, 6], "\u265E", 'Black').symbol
    grid[0][7] = Rock.new([0, 7], "\u265C", 'Black').symbol
    8.times { |col| grid[1][col] = Pawn.new([1, col], "\u265F", 'Black').symbol }

    # White pieces
    grid[7][0] = Rock.new([7, 0], "\u2656", 'White').symbol
    grid[7][1] = Knight.new([7, 1], "\u2658", 'White').symbol
    grid[7][2] = Bishop.new([7, 2], "\u2657", 'White').symbol
    grid[7][3] = Queen.new([7, 3], "\u2655", 'White').symbol
    grid[7][4] = King.new([7, 4], "\u2654", 'White').symbol
    grid[7][5] = Bishop.new([7, 5], "\u2657", 'White').symbol
    grid[7][6] = Knight.new([7, 6], "\u2658", 'White').symbol
    grid[7][7] = Rock.new([7, 7], "\u2656", 'White').symbol
    8.times { |col| grid[6][col] = Pawn.new([6, col], "\u2659", 'White').symbol }
  end
end

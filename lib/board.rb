# frozen_string_literal: true

require 'colorize'
class Board
  attr_reader :grid

  def initialize
    @grid = create_grid
  end

  def display_board
    puts '|     |  a  |  b  |  c  |  d  |  e  |  f  |  g  |  h  |'
    puts '|-----|-----|-----|-----|-----|-----|-----|-----|-----|'

    grid.each_with_index do |row, row_index|
      formatted_row = row.map.with_index do |cell, col_index|
        cell_display = cell.nil? ? '   ' : " #{cell}"
        background_color = (row_index + col_index).even? ? :white : :black
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
end

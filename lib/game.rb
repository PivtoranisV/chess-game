# frozen_string_literal: true

require_relative 'board'

class Game
  #  credit for ASCII code https://www.asciiart.eu/text-to-ascii-art
  CHESS = '////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//   ______         __    __        ________         ______          ______   //
//  /      \       /  |  /  |      /        |       /      \        /      \  //
// /$$$$$$  |      $$ |  $$ |      $$$$$$$$/       /$$$$$$  |      /$$$$$$  | //
// $$ |  $$/       $$ |__$$ |      $$ |__          $$ \__$$/       $$ \__$$/  //
// $$ |            $$    $$ |      $$    |         $$      \       $$      \  //
// $$ |   __       $$$$$$$$ |      $$$$$/           $$$$$$  |       $$$$$$  | //
// $$ \__/  |      $$ |  $$ |      $$ |_____       /  \__$$ |      /  \__$$ | //
// $$    $$/       $$ |  $$ |      $$       |      $$    $$/       $$    $$/  //
//  $$$$$$/        $$/   $$/       $$$$$$$$/        $$$$$$/         $$$$$$/   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////'
  def initialize
    puts CHESS
    @board = Board.new
    display_board
  end

  def display_board
    puts '    |  a  |  b  |  c  |  d  |  e  |  f  |  g  |  h  |'
    puts '----|-----|-----|-----|-----|-----|-----|-----|-----|----'

    @board.grid.reverse.each_with_index do |row, row_index|
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

  private

  def colorize_piece(piece)
    piece_color = piece.color == :black ? :black : :white
    piece.symbol.colorize(color: piece_color)
  end
end

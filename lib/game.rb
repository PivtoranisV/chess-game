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

  PIECES_COLORS = %i[white black].freeze

  def initialize
    puts CHESS
    @board = Board.new
  end

  def setup_players
    @player1 = create_player('Chess Player 1', nil)
    @player2 = create_player('Chess Player 2', @player1.color)
    sleep(1)
    display_board
  end

  private

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

  def colorize_piece(piece)
    piece_color = piece.color == :black ? :black : :white
    piece.symbol.colorize(color: piece_color)
  end

  def create_player(default_name, other_color)
    puts "\n#{default_name}, please enter your name:\n"
    name = gets.chomp
    name = default_name if name.strip.empty?
    color = player_color(other_color)
    puts "\n#{name}, you will play for #{color} team\n"
    Player.new(name, color)
  end

  def player_color(color = nil)
    return PIECES_COLORS.sample unless color

    PIECES_COLORS.reject { |el| el == color }[0]
  end
end

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
    display_board
  end

  def setup_players
    puts 'Player 1, please enter your name:'
    player1_name = gets.chomp
    player1_name = 'Player 1' if player1_name.strip.empty?
    player1_color = player_color
    puts "#{player1_name}, you will play for #{player1_color} team"
    puts 'Player 2, please enter your name:'
    player2_name = gets.chomp
    player2_name = 'Player 2' if player2_name.strip.empty?
    player2_color = player_color(player1_color)
    puts "#{player2_name}, you will play for #{player2_color} team"
    sleep(1)
    @player1 = Player.new(player1_name, player1_color)
    @player2 = Player.new(player2_name, player2_color)
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

  def player_color(color = nil)
    return PIECES_COLORS.sample unless color

    PIECES_COLORS.reject { |el| el == color }[0]
  end
end

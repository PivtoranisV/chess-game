# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

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
    puts "\n Hi everyone, if you are not familiar with chess rules, please type help,
    if you want to save yor game, please type save\n"
    @board = Board.new
    setup_players
  end

  def play
    if @player1.color == :white
      white_player = @player1
      black_player = @player2
    else
      white_player = @player2
      black_player = @player1
    end
    loop do
      player_turn(white_player)
      break if game_over?(:black)

      player_turn(black_player)
      break if game_over?(:white)
    end
  end

  private

  def game_over?(color)
    if @board.checkmate?(color)
      puts "Checkmate! #{color == :white ? 'WHITE' : 'BLACK'} is the winner."
      true
    elsif @board.stalemate?(color)
      puts "It's a draw!"
      true
    else
      false
    end
  end

  def player_turn(player)
    puts "#{player.name}, your King in the check, please protect him" if @board.king_in_check?(player.color)
    move = player.make_move(@board)
    @board.update_board(move)
    display_board
  end

  def setup_players
    @player1 = create_player('Chess Player', nil)
    @player2 = create_player('Chess Player', @player1.color)
    sleep(1)
    display_board
  end

  def display_board
    puts '    a   b   c   d   e   f   g   h '
    puts '  +---+---+---+---+---+---+---+---+'

    @board.grid.reverse.each_with_index do |row, row_index|
      formatted_row = row.map.with_index do |cell, col_index|
        cell_display = cell.nil? ? '   ' : " #{colorize_piece(cell)} "
        background_color = (row_index + col_index).even? ? :green : :light_blue
        cell_display.colorize(background: background_color)
      end.join('|')

      puts "#{8 - row_index} |#{formatted_row}| #{8 - row_index}"
      puts '  +---+---+---+---+---+---+---+---+'
    end

    puts '     a   b   c   d   e   f   g   h '
  end

  def colorize_piece(piece)
    piece_color = piece.color == :black ? :black : :light_white
    piece.symbol.colorize(color: piece_color, mode: :bold)
  end

  def create_player(default_name, other_color)
    puts "\n#{default_name}, please enter your name:\n"
    name = gets.chomp
    name = default_name if name.strip.empty?
    color = player_color(other_color)
    puts "\n#{name}, you will play for #{color.upcase} team\n"
    Player.new(name, color)
  end

  def player_color(color = nil)
    return PIECES_COLORS.sample unless color

    PIECES_COLORS.reject { |el| el == color }[0]
  end
end

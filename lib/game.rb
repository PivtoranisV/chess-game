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
    puts "\n Hi everyone, if you are not familiar with chess rules, please type help,
    if you want to save yor game, please type save\n"
    @board = Board.new
    setup_players
  end

  def self.start
    puts CHESS
    puts 'Would you like to (1) start a new game or (2) load a saved game?'
    choice = gets.chomp

    if choice == '2'

      game = load_game
      if game
        puts "\nYour saved game load successfully, continue to play\n"
        puts game.display_board
        game.play
      else
        puts "\nNew game started"
        Game.new.play
      end
    else
      puts "\nNew game started"
      Game.new.play
    end
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

  def self.load_game
    if File.exist?('saved_game')
      File.open('saved_game') do |file|
        return Marshal.load(file)
      end
    else
      puts "\nNo saved game found"
      nil
    end
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
    if move == 'save'
      save_game
    else
      @board.update_board(move)
      display_board
    end
  end

  def setup_players
    @player1 = create_player('Chess Player', nil)
    @player2 = create_player('Chess Player', @player1.color)
    sleep(1)
    display_board
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

  def save_game
    File.open('saved_game', 'w') do |file|
      Marshal.dump(self, file)
    end
  end
end

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
    puts "\nWelcome to Chess! Here are some commands you can use during the game:\n".colorize(color: :yellow)
    puts "#{'help'.colorize(color: :yellow)} - Display the game rules"
    puts "#{'save'.colorize(color: :yellow)} - Save your current game"
    puts "#{'exit'.colorize(color: :yellow)} - Exit the game\n\n"
    @board = Board.new
    @current_turn = :white
    setup_players
  end

  def self.start
    puts CHESS.colorize(color: :yellow)
    puts "\nWould you like to
    #{'(1)'.colorize(color: :green)} start a new game
    or #{'(2)'.colorize(color: :green)} load a saved game?"
    choice = gets.chomp

    if choice == '2'

      game = load_game
      if game
        puts "\nYour saved game load successfully, continue to play\n".colorize(color: :green)
        puts game.display_board
        game.play
      else
        puts "\nStarting a new game.".colorize(color: :red)
        Game.new.play
      end
    else
      puts "\nNew game started".colorize(color: :green)
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
      if @current_turn == :white
        player_turn(white_player)
        @current_turn = :black
      else
        player_turn(black_player)
        @current_turn = :white
      end

      break if game_over?(@current_turn == :white ? :black : :white)
    end
  end

  def self.load_game
    puts 'Enter the name of the saved game file to load:'.colorize(color: :green)
    file_name = gets.chomp
    if File.exist?("saved_games/#{file_name}_saved_game")
      begin
        File.open("saved_games/#{file_name}_saved_game") do |file|
          return Marshal.load(file)
        end
      rescue StandardError => e
        puts "Error loading game: #{e.message}. The save file may be corrupted."
        nil
      end
    else
      puts "\nNo saved game found with that name.".colorize(color: :red)
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

    puts '    a   b   c   d   e   f   g   h '
  end

  private

  def game_over?(color)
    if @board.checkmate?(color)
      puts "Checkmate! #{color == :white ? 'WHITE' : 'BLACK'} wins the game.".colorize(color: :blue)
      true
    elsif @board.stalemate?(color)
      puts "It's a draw!".colorize(color: :blue)
      true
    else
      false
    end
  end

  def player_turn(player)
    puts "\n#{player.name}'s turn (#{player.color.to_s.upcase} pieces)".colorize(color: :blue)
    puts 'Your King is in check, protect it!'.colorize(color: :red) if @board.king_in_check?(player.color)

    puts "\nPlease enter your move (e.g., 'e2e4'), or type 'save' to save the game, 'exit' to quit:".colorize(color: :green)
    move = player.make_move(@board)

    case move
    when 'save'
      save_game
      player_turn(player)
    when 'exit'
      puts 'Thank you for playing!'.colorize(color: :blue)
      exit
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
    puts "\n#{default_name}, please enter your name:\n".colorize(color: :green)
    name = gets.chomp
    name = default_name if name.strip.empty?
    color = player_color(other_color)
    puts "\n#{name}, you will play for #{color.upcase} team\n".colorize(color: :blue)
    Player.new(name, color)
  end

  def player_color(color = nil)
    return PIECES_COLORS.sample unless color

    PIECES_COLORS.reject { |el| el == color }[0]
  end

  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    puts 'Enter a name for your save file:'.colorize(color: :green)
    file_name = gets.chomp
    File.open("saved_games/#{file_name}_saved_game", 'w') do |file|
      Marshal.dump(self, file)
    end
    puts "Game saved as #{file_name}_saved_game.".colorize(color: :blue)
  end
end

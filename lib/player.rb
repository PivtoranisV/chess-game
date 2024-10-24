# frozen_string_literal: true

require 'colorize'
require_relative 'pieces/bishop'

# The Player class represents a player in the chess game.
# It manages player information and handles user input for making moves.
class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  # Prompts the player for a move and processes the input.
  # It handles special commands (help, save, exit) and validates the move.
  def make_move(board)
    input = gets.chomp.downcase
    if input == 'help'
      display_help
      make_move(board)
    elsif %w[save exit].include?(input)
      input
    elsif valid_input_format?(input)
      positions = convert_input(input)

      if valid_move?(board, positions)
        positions
      else
        puts 'Invalid move. Please try again.'.colorize(color: :red)
        make_move(board)
      end
    else
      puts 'Invalid input format. Use notation like e2e4.'.colorize(color: :red)
      make_move(board)
    end
  end

  private

  # Converts the user input from algebraic notation to board positions.
  def convert_input(input)
    converted_input = input.split('').map do |char|
      char.match?(/[a-z]/) ? char.ord - 97 : char.to_i - 1
    end

    start_position = converted_input[0..1].reverse
    end_position = converted_input[2..3].reverse
    [start_position, end_position]
  end

  def valid_input_format?(input)
    # Input length validation
    if input.length != 4
      puts 'You entered less or more than 4 characters'.colorize(color: :red)
      return false
    end

    # Constants for valid inputs
    valid_columns = ('a'..'h').to_a
    valid_rows = ('1'..'8').to_a

    # Validate input characters for columns
    unless valid_columns.include?(input[0]) && valid_columns.include?(input[2])
      puts 'The first and third characters must be letters from a to h'.colorize(color: :red)
      return false
    end

    # Validate input characters for row
    unless valid_rows.include?(input[1]) && valid_rows.include?(input[3])
      puts 'The second and fourth characters must be numbers from 1 to 8'.colorize(color: :red)
      return false
    end
    true
  end

  # Checks if a move is valid based on the game rules and current board state.
  def valid_move?(board, positions)
    start_position, end_position = positions

    # Check if piece exists at the start position
    piece = board.square_occupied(start_position)
    if piece.nil?
      puts 'No piece at the selected start position.'.colorize(color: :red)
      return false
    end

    # Check if player move with own color piece
    if piece.color != color
      puts "You can move only your #{color} pieces.".colorize(color: :red)
      return false
    end

    # Checks if end_position is part of possible moves
    possible_moves = piece.possible_moves(board)

    unless possible_moves.include?(end_position)
      puts 'Provided move is not allowed'.colorize(color: :red)
      return false
    end

    # Simulate the move and check if it places or leaves the King in check
    if board.simulate_move_and_check?(piece, end_position)
      puts 'This move would place your King in check!'.colorize(color: :red)
      return false
    end

    true
  end

  def display_help
    puts 'Chess Game Rules:'
    puts '- The game is played between two players, each starting with 16 pieces (white vs. black).'
    puts '- Objective: Checkmate your opponent by trapping their King so it cannot escape capture.'
    puts '- The game is played on an 8x8 board, with each player taking alternate turns.'
    puts '- Piece Movement:'
    puts '  - King: Moves one square in any direction.'
    puts '  - Queen: Moves any number of squares in any direction.'
    puts '  - Rook: Moves any number of squares horizontally or vertically.'
    puts '  - Bishop: Moves any number of squares diagonally.'
    puts '  - Knight: Moves in an "L" shape.'
    puts '- How to Enter a Move:'
    puts '- Use long algebraic notation (e.g., e2e4).'
    puts '- Enter the starting and ending squares (e.g., g1f3).'
    puts '- Special commands:'
    puts '  - Type "save" to save the game.'
    puts '  - Type "exit" to quit the game.'
    puts '- A game can end by checkmate, stalemate (no legal moves).'
  end
end

# frozen_string_literal: true

require_relative 'pieces/bishop'

class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def make_move(board)
    puts "\n#{name}, please choose your next move"
    puts 'Please enter your move using long algebraic notation (e.g., e2e4):'

    input = gets.chomp

    converted_input = input.split('').map do |char|
      char.match?(/[a-z]/) ? char.ord - 97 : char.to_i - 1
    end

    start_position = converted_input[0..1].reverse
    end_position = converted_input[2..3].reverse
    positions = [start_position, end_position]

    if valid_move?(board, positions, input)
      positions
    else
      puts 'Invalid move. Try Again'
      make_move(board)
    end
  end

  def valid_move?(board, positions, input)
    start_position, end_position = positions

    # Input length validation
    if input.length != 4
      puts 'You entered less or more than 4 characters'
      return false
    end

    # Constants for valid inputs
    valid_columns = ('a'..'h').to_a
    valid_rows = ('1'..'8').to_a

    # Validate input characters for columns
    unless valid_columns.include?(input[0]) && valid_columns.include?(input[2])
      puts 'The first and third characters must be letters from a to h'
      return false
    end
    # Validate input characters for row
    unless valid_rows.include?(input[1]) && valid_rows.include?(input[3])
      puts 'The second and fourth characters must be numbers from 1 to 8'
      return false
    end

    # Check if piece exists at the start position
    piece = board.square_occupied?(start_position)
    if piece.nil?
      puts 'No piece at the selected start position.'
      return false
    end

    # Checks if end_position is part of possible moves
    possible_moves = piece.possible_moves(board)

    unless possible_moves.include?(end_position)
      puts 'Provided move is not allowed'
      return false
    end

    true
  end
end

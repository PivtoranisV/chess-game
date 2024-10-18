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

    # possible_moves = piece.possible_moves(board)

    if input.length != 4
      puts 'You enter less or more than 4 characters'
      return false
    end

    piece = board.square_occupied?(start_position)
    if piece.nil?
      puts 'No piece at the selected start position.'
      return false
    end
    true
  end
end

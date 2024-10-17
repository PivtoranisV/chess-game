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
    [start_position, end_position]
  end
end

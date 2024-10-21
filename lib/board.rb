# frozen_string_literal: true

require 'colorize'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'

# The Board class represents the chess game board and manages the state of the game.
# It handles piece placement, movement, and game logic related to checking conditions like, checkmate, and stalemate.
class Board
  attr_reader :grid

  def initialize
    @grid = create_grid
    populate_pieces
  end

  def stalemate?(color)
    return false if king_in_check?(color)

    player_pieces = grid.flatten.compact.select { |piece| piece.color == color }

    player_pieces.any? do |piece|
      moves = piece.possible_moves(self)

      moves.any? { |move| simulate_move_and_check?(piece, move) }
    end
  end

  # Returns the piece located at the specified position.
  def square_occupied(position)
    position_x, position_y = position
    grid[position_x][position_y]
  end

  # Updates the board to reflect a move from start to end position.
  def update_board(positions)
    start_position, end_position = positions
    piece = square_occupied(start_position)

    grid[start_position[0]][start_position[1]] = nil
    grid[end_position[0]][end_position[1]] = piece
    piece.position = end_position
  end

  def king_in_check?(color)
    king_position = find_king_position(color)

    opponent_pieces = grid.flatten.compact.reject { |piece| piece.color == color }

    opponent_pieces.any? do |piece|
      piece.possible_moves(self).include?(king_position)
    end
  end

  def checkmate?(color)
    return false unless king_in_check?(color)

    player_pieces = grid.flatten.compact.select { |piece| piece.color == color }

    player_pieces.each do |piece|
      piece.possible_moves(self).each do |move|
        return false unless simulate_move_and_check?(piece, move)
      end
    end
    true
  end

  # Simulates a move, checks if the king is still in check after the move, and reverts the move.
  def simulate_move_and_check?(piece, move)
    start_position = piece.position
    end_position = move
    captured_piece = square_occupied(end_position)

    update_board([start_position, end_position])

    king_still_in_check = king_in_check?(piece.color)

    # Undo the move
    update_board([end_position, start_position])
    grid[end_position[0]][end_position[1]] = captured_piece
    piece.position = start_position

    king_still_in_check
  end

  private

  def find_king_position(color)
    king = grid.flatten.compact.find { |piece| piece.instance_of?(King) && piece.color == color }
    king.position
  end

  def create_grid
    Array.new(8) { Array.new(8) }
  end

  def populate_pieces
    piece_positions = {
      black: { row1: [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook],
               row2: [Pawn] * 8 },
      white: { row1: [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook],
               row2: [Pawn] * 8 }
    }

    # Placing white pieces
    place_pieces(piece_positions[:white][:row1], 0, :white)
    place_pieces(piece_positions[:white][:row2], 1, :white)

    # Placing black pieces
    place_pieces(piece_positions[:black][:row1], 7, :black)
    place_pieces(piece_positions[:black][:row2], 6, :black)
  end

  def place_pieces(pieces, row, color)
    pieces.each_with_index do |piece_class, col|
      grid[row][col] = piece_class.new([row, col], color)
    end
  end
end

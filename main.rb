# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/pieces/knight'
require_relative 'lib/pieces/rook'

board = Board.new
board.display_board

rook = Rook.new([2, 0], :black)

p rook.possible_moves(board)

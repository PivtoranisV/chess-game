# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/pieces/knight'

Board.new.display_board
knight = Knight.new([0, 1], :black)
p knight.position

p knight.possible_moves

# frozen_string_literal: true

require_relative 'pieces'

class Pawn < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265F" : "\u2659", color)
  end
end

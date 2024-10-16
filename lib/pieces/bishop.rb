# frozen_string_literal: true

require_relative 'pieces'

class Bishop < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265D" : "\u2657", color)
  end
end

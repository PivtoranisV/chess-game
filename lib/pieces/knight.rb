# frozen_string_literal: true

require_relative 'pieces'

class Knight < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265E" : "\u2658", color)
  end
end

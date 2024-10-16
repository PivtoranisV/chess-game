# frozen_string_literal: true

require_relative 'pieces'

class Rock < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265C" : "\u2656", color)
  end
end

# frozen_string_literal: true

require_relative 'pieces'

class King < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265A" : "\u2654", color)
  end
end

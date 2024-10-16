# frozen_string_literal: true

require_relative 'pieces'

class Queen < Pieces
  def initialize(position, color)
    super(position, color == :black ? "\u265B" : "\u2655", color)
  end
end

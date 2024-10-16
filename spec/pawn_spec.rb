# frozen_string_literal: true

require_relative '../lib/pieces/pawn'

describe Pawn do
  context 'When White Pawn is at position [6, 3]' do
    subject(:pawn63) { described_class.new([6, 3], :white) }
    it 'should return valid possible moves' do
      expected_moves = [[5, 3], [4, 3]]
      expect(pawn63.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When Black Pawn is at position [1, 4]' do
    subject(:pawn14) { described_class.new([1, 4], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[2, 4], [3, 4]]
      expect(pawn14.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When White Pawn is at position [4, 3]' do
    subject(:pawn43) { described_class.new([4, 3], :white) }
    it 'should return valid possible moves' do
      expected_moves = [[3, 3]]
      expect(pawn43.possible_moves).to match_array(expected_moves)
    end
  end
end

# frozen_string_literal: true

require_relative '../lib/pieces/knight'

describe Knight do
  context 'When Knight is at position [0, 1]' do
    subject(:knight01) { described_class.new([0, 1], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[2, 2], [2, 0], [1, 3]]
      expect(knight01.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When Knight is at position [7, 0]' do
    subject(:knight70) { described_class.new([7, 0], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[5, 1], [6, 2]]
      expect(knight70.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When Knight is at position [4, 4]' do
    subject(:knight44) { described_class.new([4, 4], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[6, 5], [6, 3], [2, 5], [2, 3], [5, 6], [5, 2], [3, 6], [3, 2]]
      expect(knight44.possible_moves).to match_array(expected_moves)
    end
  end
end

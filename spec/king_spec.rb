# frozen_string_literal: true

require_relative '../lib/pieces/king'

describe King do
  context 'when King is at position [4, 4]' do
    subject(:king44) { described_class.new([4, 4], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[5, 4], [3, 4], [4, 5], [4, 3],
                        [5, 5], [5, 3], [3, 5], [3, 3]]
      expect(king44.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When King is at position [0, 0]' do
    subject(:king00) { described_class.new([0, 0], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[1, 0], [0, 1], [1, 1]]
      expect(king00.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When King is at position [7, 3]' do
    subject(:king73) { described_class.new([7, 3], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[6, 3], [7, 4], [7, 2], [6, 4], [6, 2]]
      expect(king73.possible_moves).to match_array(expected_moves)
    end
  end
end

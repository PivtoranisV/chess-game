# frozen_string_literal: true

require_relative '../lib/pieces/rook'

describe Rook do
  context 'When Rook is at position [0, 1]' do
    subject(:rook01) { described_class.new([0, 1], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[7, 1], [6, 1], [5, 1], [4, 1], [3, 1], [2, 1], [1, 1], [0, 7], [0, 6],
                        [0, 5], [0, 4], [0, 3], [0, 2], [0, 0]]
      expect(rook01.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When Rook is at position [7, 0]' do
    subject(:rook70) { described_class.new([7, 0], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 7], [7, 6],
                        [7, 5], [7, 4], [7, 3], [7, 2], [7, 1]]
      expect(rook70.possible_moves).to match_array(expected_moves)
    end
  end
  context 'When Rook is at position [4, 4]' do
    subject(:rook44) { described_class.new([4, 4], :black) }
    it 'should return valid possible moves' do
      expected_moves = [[7, 4], [6, 4], [5, 4], [0, 4], [1, 4], [2, 4], [3, 4], [4, 7], [4, 6],
                        [4, 5], [4, 0], [4, 1], [4, 2], [4, 3]]
      expect(rook44.possible_moves).to match_array(expected_moves)
    end
  end
end

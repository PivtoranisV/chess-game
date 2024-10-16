# frozen_string_literal: true

require_relative '../lib/pieces/bishop'

describe Bishop do
  context 'When Bishop position is [0, 0]' do
    subject(:bishop01) { described_class.new([0, 0], :black) }
    it 'should return valid possible moves' do
      expect(bishop01.possible_moves).to eq([[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]])
    end
  end
  context 'When Bishop position is [7, 0]' do
    subject(:bishop70) { described_class.new([7, 0], :black) }
    it 'should return valid possible moves' do
      expect(bishop70.possible_moves).to eq([[0, 7], [1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1]])
    end
  end
  context 'When Bishop position is [4, 4]' do
    subject(:bishop44) { described_class.new([4, 4], :black) }
    it 'should return valid possible moves' do
      expect(bishop44.possible_moves).to eq([[7, 7], [6, 6], [5, 5], [0, 0], [1, 1], [2, 2], [3, 3], [7, 1], [6, 2],
                                             [5, 3], [1, 7], [2, 6], [3, 5]])
    end
  end
end

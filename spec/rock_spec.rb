# frozen_string_literal: true

require_relative '../lib/pieces/rock'

describe Rock do
  context 'When Rock position is [0, 1]' do
    subject(:rock01) { described_class.new([0, 1], :black) }
    it 'should return valid possible moves' do
      expect(rock01.possible_moves).to eq([[1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [0, 2], [0, 3],
                                           [0, 4], [0, 5], [0, 6], [0, 7], [0, 0]])
    end
  end
  context 'When Rock position is [7, 0]' do
    subject(:rock70) { described_class.new([7, 0], :black) }
    it 'should return valid possible moves' do
      expect(rock70.possible_moves).to eq([[6, 0], [5, 0], [4, 0], [3, 0], [2, 0], [1, 0], [0, 0], [7, 1], [7, 2],
                                           [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]])
    end
  end
  context 'When Rock position is [4, 4]' do
    subject(:rock44) { described_class.new([4, 4], :black) }
    it 'should return valid possible moves' do
      expect(rock44.possible_moves).to eq([[5, 4], [6, 4], [7, 4], [3, 4], [2, 4], [1, 4], [0, 4], [4, 5], [4, 6],
                                           [4, 7], [4, 3], [4, 2], [4, 1], [4, 0]])
    end
  end
end

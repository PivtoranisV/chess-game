# frozen_string_literal: true

require_relative '../lib/pieces/pawn'
require_relative '../lib/board'

describe Pawn do
  let(:board) { instance_double(Board) }

  before do
    allow(board).to receive(:square_occupied?).and_return(nil)
  end

  context 'When White Pawn is at position [6, 3]' do
    subject(:pawn63) { described_class.new([6, 3], :white) }
    it 'should return valid possible moves' do
      expected_moves = [[5, 3], [4, 3]]
      expect(pawn63.possible_moves(board)).to match_array(expected_moves)
    end
  end
  context 'When Black Pawn is not at starting position' do
    subject(:pawn20) { described_class.new([2, 0], :black) }
    it 'should return valid possible move' do
      expected_moves = [[3, 0]]
      expect(pawn20.possible_moves(board)).to match_array(expected_moves)
    end
  end
  context 'When Black Pawn is blocked by other piece' do
    subject(:pawn14) { described_class.new([1, 4], :black) }
    it 'should return valid possible moves' do
      allow(board).to receive(:square_occupied?).with([2, 4]).and_return(double('Piece', color: :white))
      expected_moves = []
      expect(pawn14.possible_moves(board)).to match_array(expected_moves)
    end
  end
  context 'When White Pawn is capturing' do
    subject(:pawn43) { described_class.new([4, 3], :white) }
    it 'should return valid possible moves for capturing' do
      allow(board).to receive(:square_occupied?).with([3, 2]).and_return(double('Piece', color: :black))
      expected_moves = [[3, 2], [3, 3]]
      expect(pawn43.possible_moves(board)).to match_array(expected_moves)
    end
  end
end

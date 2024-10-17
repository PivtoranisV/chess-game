# frozen_string_literal: true

require_relative '../lib/pieces/rook'
require_relative '../lib/board'

describe Rook do
  let(:board) { instance_double(Board) }

  before do
    allow(board).to receive(:square_occupied?).and_return(nil)
  end

  context 'When Rook is at position [0, 1]' do
    subject(:rook01) { described_class.new([0, 1], :black) }

    it 'should return valid possible moves' do
      expected_moves = [[0, 0], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1],
                        [6, 1], [7, 1]]
      expect(rook01.possible_moves(board)).to match_array(expected_moves)
    end
  end

  context 'When Rook is blocked by its own pieces' do
    subject(:rook44) { described_class.new([4, 4], :black) }

    it 'should stop at the first friendly piece' do
      allow(board).to receive(:square_occupied?).with([4, 5]).and_return(double('Piece', color: :black))
      allow(board).to receive(:square_occupied?).with([4, 3]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([4, 2]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([4, 1]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([4, 0]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([3, 4]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([2, 4]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([1, 4]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([0, 4]).and_return(nil)

      expected_moves = [[0, 4], [1, 4], [2, 4], [3, 4], [4, 0], [4, 1], [4, 2], [4, 3], [5, 4], [6, 4], [7, 4]]
      expect(rook44.possible_moves(board)).to match_array(expected_moves)
    end
  end

  context 'When Rook captures an opponent piece' do
    subject(:rook70) { described_class.new([7, 0], :black) }

    it 'should stop after capturing' do
      allow(board).to receive(:square_occupied?).with([6, 0]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([5, 0]).and_return(double('Piece', color: :white))
      allow(board).to receive(:square_occupied?).with([4, 0]).and_return(nil)

      expected_moves = [[6, 0], [5, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]]
      expect(rook70.possible_moves(board)).to match_array(expected_moves)
    end
  end
end

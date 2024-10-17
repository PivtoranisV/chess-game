# frozen_string_literal: true

require_relative '../lib/pieces/bishop'
require_relative '../lib/board'

describe Bishop do
  let(:board) { instance_double(Board) }

  before do
    allow(board).to receive(:square_occupied?).and_return(nil)
  end

  context 'When Bishop is at position [0, 0]' do
    subject(:bishop00) { described_class.new([0, 0], :black) }

    it 'should return valid possible moves' do
      expected_moves = [[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]]
      expect(bishop00.possible_moves(board)).to match_array(expected_moves)
    end
  end
  context 'When Bishop is blocked by its own pieces' do
    subject(:bishop70) { described_class.new([7, 0], :white) }
    it 'should return valid possible moves' do
      allow(board).to receive(:square_occupied?).with([4, 3]).and_return(double('Piece', color: :white))
      allow(board).to receive(:square_occupied?).with([5, 2]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([6, 1]).and_return(nil)

      expected_moves = [[5, 2], [6, 1]]
      expect(bishop70.possible_moves(board)).to match_array(expected_moves)
    end
  end
  context 'When Bishop captures an opponent piece' do
    subject(:bishop44) { described_class.new([4, 4], :black) }
    it 'should return valid possible moves' do
      allow(board).to receive(:square_occupied?).with([7, 7]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([5, 3]).and_return(double('Piece', color: :white))
      allow(board).to receive(:square_occupied?).with([3, 5]).and_return(nil)

      expected_moves = [[7, 7], [6, 6], [5, 5], [0, 0], [1, 1], [2, 2], [3, 3],
                        [5, 3], [1, 7], [2, 6], [3, 5]]
      expect(bishop44.possible_moves(board)).to match_array(expected_moves)
    end
  end
end

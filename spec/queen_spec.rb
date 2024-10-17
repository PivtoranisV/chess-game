# frozen_string_literal: true

require_relative '../lib/pieces/queen'

describe Queen do
  let(:board) { instance_double(Board) }

  before do
    allow(board).to receive(:square_occupied?).and_return(nil)
  end

  context 'when Queen is at position [0, 0]' do
    subject(:queen00) { described_class.new([0, 0], :black) }
    it 'returns all valid moves' do
      expected_moves = [
        [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
        [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
        [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]
      ]
      expect(queen00.possible_moves(board)).to match_array(expected_moves)
    end
  end
  context 'when Queen is blocked by its own pieces' do
    subject(:queen44) { described_class.new([4, 4], :black) }
    it 'returns all valid moves' do
      allow(board).to receive(:square_occupied?).with([4, 3]).and_return(double('Piece', color: :black))
      allow(board).to receive(:square_occupied?).with([5, 4]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([1, 7]).and_return(nil)

      expected_moves = [
        [5, 4], [6, 4], [7, 4], [3, 4], [2, 4], [1, 4], [0, 4], [4, 5],
        [4, 6], [4, 7], [5, 5], [6, 6], [7, 7], [3, 3], [2, 2], [1, 1],
        [0, 0], [5, 3], [6, 2], [7, 1], [3, 5], [2, 6], [1, 7]
      ]
      expect(queen44.possible_moves(board)).to match_array(expected_moves)
    end
  end
  context 'when Queen captures an opponent piece' do
    subject(:queen73) { described_class.new([7, 3], :black) }
    it 'returns all valid moves' do
      allow(board).to receive(:square_occupied?).with([6, 3]).and_return(nil)
      allow(board).to receive(:square_occupied?).with([6, 3]).and_return(double('Piece', color: :white))
      allow(board).to receive(:square_occupied?).with([4, 0]).and_return(nil)

      expected_moves = [
        [6, 3], [7, 4], [7, 5], [7, 6], [7, 7], [7, 2], [7, 1], [7, 0],
        [6, 4], [5, 5], [4, 6], [3, 7], [6, 2], [5, 1], [4, 0]
      ]
      expect(queen73.possible_moves(board)).to match_array(expected_moves)
    end
  end
end

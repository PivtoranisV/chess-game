# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    context 'When board initialize' do
      it 'Creates a board with 8 columns and 8 rows' do
        expect(board.grid.length).to eq(8)
        expect(board.grid.all? { |row| row.length == 8 }).to be true
      end

      it 'Place White Rook in the first column of first row' do
        expect(board.grid[0][0].symbol).to eq("\u2656")
      end
      it 'Place White Knight in the second column of first row' do
        expect(board.grid[0][1].symbol).to eq("\u2658")
      end
      it 'Place White King in the fifth column of first row' do
        expect(board.grid[0][4].symbol).to eq("\u2654")
      end
      it 'Place Black King in the fifth column of last row' do
        expect(board.grid[7][4].symbol).to eq("\u265A")
      end
      it 'Place Black Knight in the second column of last row' do
        expect(board.grid[7][1].symbol).to eq("\u265E")
      end
      it 'Place Black pawns in the each column of second row' do
        expect(board.grid[1].all? { |cell| cell.symbol == "\u2659" }).to be true
      end
    end
  end

  describe '#update_board' do
    context 'When player makes a move' do
      it 'updates the piece position on the board' do
        expect(board.grid[1][0].symbol).to eq("\u2659")
        board.update_board([[1, 0], [2, 0]])

        expect(board.grid[2][0].symbol).to eq("\u2659")
        expect(board.grid[1][0]).to be_nil
      end
    end
  end
end

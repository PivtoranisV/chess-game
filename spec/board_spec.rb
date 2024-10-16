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

      it 'Place Rock in the first column of first row' do
        expect(board.grid[0][0]).to eq("\u2656")
      end
    end
  end
end

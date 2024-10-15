# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'Creates an empty board with 8 columns and 8 rows' do
      expect(board.grid.length).to eq(8)
      expect(board.grid.all? { |row| row.length == 8 }).to be true
    end
  end
end

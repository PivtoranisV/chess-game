# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#make_move' do
    subject(:player) { described_class.new('Bob', :white) }
    let(:board) { instance_double(Board) }

    context 'When get valid input from player' do
      it 'correctly converts long algebraic notation to board coordinates' do
        allow(player).to receive(:gets).and_return('e2e4')
        result = player.make_move(board)
        expect(result).to eq([[1, 4], [3, 4]])
      end

      it 'handles another valid input' do
        allow(player).to receive(:gets).and_return('a7a6')
        result = player.make_move(board)
        expect(result).to eq([[6, 0], [5, 0]])
      end
    end

    context 'When invalid input provided' do
      it 'prompts for input again and returns board coordinates' do
        allow(player).to receive(:gets).and_return('invalid', 'g2g4')
        result = player.make_move(board)
        expect(result).to eq([[0, 6], [3, 6]])
      end
    end
  end
end

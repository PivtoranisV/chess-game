# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#make_move' do
    subject(:player) { described_class.new('Bob', :white) }
    let(:board) { instance_double(Board) }

    context 'When valid input is provided by the player' do
      it 'correctly converts long algebraic notation to board coordinates' do
        allow(player).to receive(:gets).and_return('e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(true)

        result = player.make_move(board)

        expect(result).to eq([[1, 4], [3, 4]])
      end

      it 'handles another valid input' do
        allow(player).to receive(:gets).and_return('a7a6')
        allow(board).to receive(:square_occupied?).with([6, 0]).and_return(true)

        result = player.make_move(board)

        expect(result).to eq([[6, 0], [5, 0]])
      end
    end

    context 'When input is invalid length' do
      it 'rejects input with less than 4 characters' do
        allow(player).to receive(:gets).and_return('e2e', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(true)

        expect { player.make_move(board) }.to output(/Invalid move. Try Again/).to_stdout
      end

      it 'rejects input with more than 4 characters' do
        allow(player).to receive(:gets).and_return('invalid', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(true)

        expect { player.make_move(board) }.to output(/Invalid move. Try Again/).to_stdout
      end
    end

    context 'When invalid input is provided' do
      it 'prints invalid move message and retries input' do
        allow(player).to receive(:gets).and_return('d2d4', 'a7a6')
        allow(board).to receive(:square_occupied?).with([1, 3]).and_return(nil)
        allow(board).to receive(:square_occupied?).with([6, 0]).and_return(true)

        expect { player.make_move(board) }.to output(/Invalid move. Try Again/).to_stdout
      end
    end
  end
end

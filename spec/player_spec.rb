# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#make_move' do
    subject(:player) { described_class.new('Bob', :white) }
    let(:board) { instance_double(Board) }
    let(:piece) { double('Piece', possible_moves: [[2, 4], [3, 4]]) }

    context 'When valid input is provided by the player' do
      it 'correctly converts long algebraic notation to board coordinates' do
        allow(player).to receive(:gets).and_return('e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(piece)
        allow(piece).to receive(:possible_moves).and_return([[1, 4], [3, 4]])

        result = player.make_move(board)

        expect(result).to eq([[1, 4], [3, 4]])
      end
    end

    context 'When input is invalid length' do
      it 'rejects input with less than 4 characters' do
        allow(player).to receive(:gets).and_return('e2e', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(piece)

        expect { player.make_move(board) }.to output(/Invalid move. Try Again/).to_stdout
      end

      it 'rejects input with more than 4 characters' do
        allow(player).to receive(:gets).and_return('invalid', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(piece)

        expect { player.make_move(board) }.to output(/Invalid move. Try Again/).to_stdout
      end
    end

    context 'When input has wrong characters' do
      it 'rejects input with invalid column characters' do
        allow(player).to receive(:gets).and_return('z2z4', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(piece)

        expect do
          player.make_move(board)
        end.to output(/The first and third characters must be letters from a to h/).to_stdout
      end

      it 'rejects input with invalid row characters' do
        allow(player).to receive(:gets).and_return('e9e4', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(piece)

        expect do
          player.make_move(board)
        end.to output(/The second and fourth characters must be numbers from 1 to 8/).to_stdout
      end
    end

    context 'When invalid input is provided' do
      it 'prints invalid move message and retries input' do
        allow(player).to receive(:gets).and_return('d2d4', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 3]).and_return(nil)
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(piece)

        expect { player.make_move(board) }.to output(/Invalid move. Try Again/).to_stdout
      end
    end

    context 'When end_position is not part of possible moves' do
      it 'rejects invalid move and retries input' do
        allow(player).to receive(:gets).and_return('e2e5', 'e2e4')
        allow(board).to receive(:square_occupied?).with([1, 4]).and_return(piece)
        allow(piece).to receive(:possible_moves).and_return([[3, 4], [2, 4]])

        expect { player.make_move(board) }.to output(/Provided move is not allowed/).to_stdout
      end
    end
  end
end

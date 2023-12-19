# frozen_string_literal: true

require 'rspec'
require_relative '../lib/player'

describe Player do
  describe '#player_move' do
    let(:player) { Player.new }

    context 'when user enters an input' do
      it 'receives a legal value' do
        allow(Kernel).to receive(:gets).and_return('1')
        expect { player.player_move }.to change { player.move }.from(nil).to(1)
      end

      xit 'raises an error on an illegal value' do
        allow(Kernel).to receive(:gets).and_raise('StandardError')
        expect { player.player_move }.to output(/Erroneous input, try again!/).to_stdout
      end
    end
  end

  describe '#turn_changer' do
    context 'when it is p1 turn' do
      subject(:turn) do
        player = described_class.new
        player.instance_variable_set(:@turn, player.instance_variable_get(:@p1))
        player
      end

      it 'changes the the turn to p2' do
        turn.turn_changer
        current_turn = turn.instance_variable_get(:@turn)
        expect(current_turn[:player]).to eq(2)
      end
    end

    context 'when it is p2 turn' do
      subject(:turn) do
        player = described_class.new
        player.instance_variable_set(:@turn, player.instance_variable_get(:@p2))
        player
      end

      it 'changes the the turn to p1' do
        turn.turn_changer
        current_turn = turn.instance_variable_get(:@turn)
        expect(current_turn[:player]).to eq(1)
      end
    end
  end
end

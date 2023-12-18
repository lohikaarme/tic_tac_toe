# frozen_string_literal: true

require 'rspec'
require_relative '../lib/player'

describe '#player_move' do

  describe Player do
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
end

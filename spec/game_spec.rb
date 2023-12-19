# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#legal_move' do
    subject(:legal_game) { described_class.new(p0: { legal_move: true }) }

    context 'when a legal move is made' do
      before do
        legal_game.instance_variable_set(:@board, Array.new(3) { Array.new(3) { { legal_move: true } } })
      end

      it 'updates @legal if the move was legal' do
        expect { legal_game.legal_move(1) }.to change { legal_game.instance_variable_get(:@legal) }.from(false).to(true)
      end
    end

    context 'when an illegal move is made' do
      before do
        legal_game.instance_variable_set(:@board, Array.new(3) { Array.new(3) { { legal_move: false } } })
        allow(legal_game).to receive(:puts)
      end

      it 'does not update @legal if the move was legal' do
        expect { legal_game.legal_move(1) }.not_to change { legal_game.instance_variable_get(:@legal) }
      end
    end
  end
end
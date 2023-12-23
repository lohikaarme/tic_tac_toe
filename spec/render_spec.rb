# frozen_string_literal: true

require_relative '../lib/render'

describe Render do
  describe '#space_check' do
    context 'when a move is legal' do
      let(:render_legal_game) { Array.new(3) { Array.new(3) { { legal_move: true } } } }

      it 'returns the positional index' do
        expect(Render.space_check(render_legal_game, 0, 0, 1)).to eq(1)
      end
    end

    context 'when a move is illegal' do
      let(:render_illegal_game) { Array.new(3) { Array.new(3) { { legal_move: false, sym: 'X' } } } }

      it 'returns the player symbol occupying the position' do
        expect(Render.space_check(render_illegal_game, 0, 0, 1)).to eq('X')
      end
    end
  end

  describe '#print_board' do
    context 'when a board is rendered' do
      let(:render_game) { Array.new(3) { Array.new(3) { { legal_move: true, sym: 'X' } } } }

      it 'prints the board to the command line' do
        expect do
          Render.print_board(render_game)
        end.to output("\n     1 | 2 | 3\n    -----------\n     4 | 5 | 6\n    -----------\n     7 | 8 | 9\n    \n").to_stdout
      end
    end
  end
end

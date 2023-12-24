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
      end

      it 'does not update @legal if the move was illegal' do
        expect(legal_game).to receive(:puts).exactly(3).times
        expect { legal_game.legal_move(1) }.not_to(change { legal_game.instance_variable_get(:@legal) })
      end
    end
  end

  describe '#update_board' do
    let(:p0) { double(legal_move: true) }
    let(:p1) { double(legal_move: false) }
    subject(:update_game) { described_class.new(p0) }

    before(:each) do
      update_game.instance_variable_set(:@board, Array.new(3) { Array.new(3) { { legal_move: true } } })
      update_game.legal_move(1) # Call legal_move to set @row and @column
    end

    context 'when the board is passed a player on a legal move' do
      it 'updates the board' do
        expect { update_game.update_board(p1) }.to(change do
          row = update_game.instance_variable_get(:@row)
          column = update_game.instance_variable_get(:@column)
          update_game.instance_variable_get(:@board)[row][column]
        end)
      end

      it 'increments the turn number' do
        expect { update_game.update_board(p1) }.to change { update_game.instance_variable_get(:@turn_num) }.by(1)
      end
    end
  end

  describe '#game_checker' do
    let(:p0) { { legal_move: true, name: 'Player 0' } }
    let(:p1) { { legal_move: false, name: 'Player 1' } }

    subject(:ending_game) { described_class.new(p0) }

    context 'board is populated with player objects' do

      before do
        ending_game.instance_variable_set(:@board, Array.new(3) { Array.new(3) {  p1  } })
      end

      it 'prints win state' do
        expect { ending_game.game_checker(p1) }.to output(/Thank you for playing!/).to_stdout
      end
    end

    context 'board is populated with a row of player objects' do
      before do
        ending_game.instance_variable_set(:@board, [
          [p0, p0, p0],
          [p1, p1, p1],
          [p0, p0, p0]
        ])
       end

      it 'prints win state' do
        expect { ending_game.game_checker(p1) }.to output(/Thank you for playing!/).to_stdout
      end
    end

    context 'board is populated with a column of player objects' do
      before do
        ending_game.instance_variable_set(:@board, [
          [p1, p0, p0],
          [p1, p0, p0],
          [p1, p0, p0]
        ])
       end

      it 'prints win state' do
        expect { ending_game.game_checker(p1) }.to output(/Thank you for playing!/).to_stdout
      end
    end

    context 'board is populated with a diagonal of player objects' do
      before do
        ending_game.instance_variable_set(:@board, [
          [p1, p0, p0],
          [p0, p1, p0],
          [p0, p0, p1]
        ])
       end

      it 'prints win state' do
        expect { ending_game.game_checker(p1) }.to output(/Thank you for playing!/).to_stdout
      end
    end

    context 'the game is a stalemate' do

      before(:each) do
        ending_game.instance_variable_set(:@board, Array.new(3) { Array.new(3) { p0 } })
        ending_game.legal_move(1) # Call legal_move to set @row and @column
      end

      it 'prints stalemate state' do
        9.times { ending_game.update_board(p0) } # Call update_board to increment @turn_num
        expect { ending_game.game_checker(p1) }.to output(/Stalemate!/).to_stdout
      end
    end
  end
end

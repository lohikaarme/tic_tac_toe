# frozen_string_literal: true

# tic_tac_toe exercise to create a 2 player game playable in terminal

# require 'pry-byebug'
require_relative 'game'
require_relative 'player'
require_relative 'render'

# binding.pry
puts "\e[H\e[2J"
players = Player.new
tic_tac_toe = Game.new(players.p0)

while tic_tac_toe.game
  unless tic_tac_toe.legal
    Render.print_board(tic_tac_toe.board)
    players.player_move
    tic_tac_toe.legal_move(players.move)
    redo
  end
  tic_tac_toe.update_board(players.turn)
  tic_tac_toe.game_checker(players.turn)
  players.turn_changer
  tic_tac_toe.legal = false
  players.move = nil
end
Render.print_board(tic_tac_toe.board)

# frozen_string_literal: true

# player actions and inputs
class Player
  attr_accessor :move, :turn
  attr_reader :p0, :p1, :p2, :turn_num

  # rubocop:disable Metrics/MethodLength
  def player_move
    i = true
    while i
      puts "#{@turn[:name]}, it is your turn, place your symbol (1-9):"
      begin
        @move = Kernel.gets.match(/\d{1}/)[0].to_i
      rescue StandardError
        puts "\n-------------------------------"
        puts '| Erroneous input, try again! |'
        puts '-------------------------------'
      else
        i = false
      end
    end
    puts "\e[H\e[2J"
  end

  def turn_changer
    @turn =
      if @turn == @p1
        @p2
      else
        @p1
      end
  end

  private

  def initialize(p1_name = 'Player1', p2_name = 'Player2')
    @p0 = {
      player: 0,
      name: 'player_0',
      sym: ' ',
      legal_move: true
    }
    @p1 = {
      player: 1,
      name: p1_name,
      sym: 'X',
      legal_move: false
    }
    @p2 = {
      player: 2,
      name: p2_name,
      sym: 'O',
      legal_move: false
    }
    @turn = @p1
    @turn_sym = @p1_sym
    @move = nil
  end

  # rubocop:enable Metrics/MethodLength
end

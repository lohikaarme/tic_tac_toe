# game logic and win/lose conditions
# frozen_string_literal: true

# comment here?
class Game
  attr_accessor :game, :board, :legal

  def legal_move(input)
    location_mapper(input)
    @legal = true if @board[@row][@column][:legal_move] == true
    if @legal
    else
      puts "\n---------------------------------------------"
      puts "| Position #{input} is an illegal move, try again! |"
      puts '---------------------------------------------'
    end
  end

  def update_board(player)
    @board[@row][@column] = player
    @turn_num += 1
  end

  def game_checker(player)
    row_checker(@board, player)
    column_checker(@board, player)
    diagonal_checker(@board, player)
    stalemate_checker
  end

  private

  def initialize(init_obj)
    @game = true
    @turn_num = 0
    @board = [
      [init_obj, init_obj, init_obj],
      [init_obj, init_obj, init_obj],
      [init_obj, init_obj, init_obj]
    ]
    @legal = false
    @won = false
  end

  def location_mapper(location)
    @row = (location / 3.0).ceil - 1
    @column = location - (@row * 3) - 1
  end

  def row_checker(board, player)
    board.each do |row|
      win_state(player) if row[0] == player && row.uniq.size == 1
    end
  end

  def column_checker(board, player)
    row_checker(board.transpose, player)
  end

  def diagonal_checker(board, player)
    slash = [
      [board[0][0], board[1][1], board[2][2]],
      [board[2][0], board[1][1], board[0][2]]
    ]
    row_checker(slash, player)
  end

  def win_state(player)
    puts "#{player[:name]} Wins!"
    puts 'Thank you for playing!'
    @won = true
    @game = false
  end

  def stalemate_checker
    return unless @turn_num >= 9 && @won == false

    puts 'Stalemate!'
    puts 'Thank you for playing!'
    @game = false
  end
end

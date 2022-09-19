# frozen_string_literal: true

# printing to console
class Render
  def self.print_board(board)
    puts "
     #{space_check(board, 0, 0, 1)} | #{space_check(board, 0, 1, 2)} | #{space_check(board, 0, 2, 3)}
    -----------
     #{space_check(board, 1, 0, 4)} | #{space_check(board, 1, 1, 5)} | #{space_check(board, 1, 2, 6)}
    -----------
     #{space_check(board, 2, 0, 7)} | #{space_check(board, 2, 1, 8)} | #{space_check(board, 2, 2, 9)}
    "
  end

  def self.space_check(board, row, column, idx)
    if board[row][column][:legal_move]
      idx
    else
      board[row][column][:sym]
    end
  end
end

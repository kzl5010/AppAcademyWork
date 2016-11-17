require_relative 'board'

class Game
  def initialize(board = Board.from_file('sudoku1-almost.txt'))
    @board = board
  end

  def get_move
    puts "What position do you want to change? (row, col)"
    row, col = gets.chomp.split(',').map(&:to_i)

    while @board[row, col].given?
      puts 'That number is given. Try again.'
      row, col = gets.chomp.split(',').map(&:to_i)
    end

    puts "What number do you want to put there?"
    num = gets.chomp.to_i
    until num.between?(1, 9)
      puts 'Number needs to be between 1 and 9. Try again: '
      num = gets.chomp.map(&:to_i)
    end
    [row, col, num]
  end

  def update_board(row, col, num)
    @board[row, col].value = num
  end

  def play
    until @board.solved?
      system('clear')
      @board.render
      row, col, num = get_move
      update_board(row, col, num)
    end
    puts "You solved it!!!!!"
  end

end

Game.new.play

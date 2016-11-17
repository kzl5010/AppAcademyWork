require_relative "board"
require_relative "human"
require_relative "computer"
require 'byebug'

class Game
  attr_accessor :board, :previous_guess

  def initialize(player = HumanPlayer.new, board = Board.new)
    @player = player
    @player.board = board
    @board = board.populate
    @previous_guess = nil
  end

  def make_guess(position)
    row, col = position
    # check for same position as previous guess
    @board[row, col].facing_up = true

    @player.received_revealed_card(position, @board[row, col].value)

    @board.render
    if previous_guess.nil?
      @previous_guess = board[row, col]
    else
      if @board[row, col].value != @previous_guess.value
        @board[row, col].facing_up = false
        @previous_guess.facing_up = false
      end

      @previous_guess = nil
    end
  end

  def play
    until @board.won?
      row, col = @player.guess_pos

      while @board[row, col].facing_up
        row, col = @player.guess_pos
      end

      make_guess([row, col])
    end

    puts "You won!!"
  end


end

if __FILE__ == $PROGRAM_NAME
  Game.new(ComputerPlayer.new).play


end

require_relative 'board'
require 'enumerator'

class Solver
  attr_reader :missing_values
  RANGE = (1..9).to_a.freeze

  def initialize(board = Board.from_file("sudoku1-almostmod.txt"))
    @board = board
    @missing_values = []
  end

  def find_missing_values
    @board.grid.each do |row|
      @missing_values << RANGE - row.map(&:value)
    end
  end

  def try_solution
    temp_board = @board.dup
    temp_miss = @missing_values.dup
    temp_board.grid.enum_for(:each_with_index).map do |row, idx|
      temp_miss[idx].shuffle!
      row.map! do |elem|
        if elem.value == 0
          elem.value = temp_miss[idx].pop
        end
        elem
      end
    end
    temp_board
  end

  def solve
    test = try_solution
    until test.solved?
      test = try_solution
    end
    test.render
  end
end

solver = Solver.new
solver.find_missing_values
solver.solve

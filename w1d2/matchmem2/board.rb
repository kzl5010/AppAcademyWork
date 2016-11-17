require_relative 'card'

class Board
  attr_accessor :grid

  CARDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].freeze

  def initialize(grid = Array.new(4) { Array.new(4) } )
    @grid = grid
  end

  def populate
    until grid.flatten.none? { |el| el.nil? }
      card_value = CARDS.sample
      count = 0
      next if grid.flatten.compact.any? { |el| el.value == card_value }
      until count == 2
        card = Card.new(card_value)
        row = rand(grid.length)
        col = rand(grid.first.length)

        if grid[row][col].nil?
          grid[row][col] = card
          count += 1
        end
      end
    end
    self
  end

  def render
    @grid.each do |row|
      row.each do |card|
        if card.facing_up
          print "#{card.value.to_s.rjust(2)} | "
        else
          print "   | "
        end
      end
      puts
    end

    puts
  end

  def won?
    @grid.flatten.all? { |el| el.facing_up }
  end

  def reveal(guessed_pos)
    row, col = guessed_pos
    unless grid[row][col].facing_up
      grid[row][col].facing_up = true
      return grid[row][col].value
    end
  end

  def [](row, col)
    @grid[row][col]
  end
end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.populate
  board.render
  p board.won?
end

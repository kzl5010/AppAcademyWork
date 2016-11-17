require_relative 'tile'

class Board
  attr_accessor :grid
  RANGE = (1..9).to_a.freeze

  def initialize(grid = Array.new(9) { Array.new(9) { String.new } })
    @grid = grid
  end

  def self.from_file(filename)
    data = File.readlines(filename).map do |row|
      row.chomp.split('').map do |el|
        el = el.to_i
        given = el.zero? ? false : true
        Tile.new(el, given)
      end
    end
    self.new(data)
  end

  def update_tile(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def render
    puts "    #{(0..8).to_a.join('   ')}".colorize(:red)
    puts '-' * 39
    grid.each_with_index do |row, idx|
      print "#{idx} ".colorize(:red)
      print '| '
      row.each do |el|
        show = (el.value.zero? ? " " : el.value)
        print "#{show} | "
      end
      puts
      puts '-' * 39
    end
  end

  def solved?
    check_all
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  private
  def check_rows
    check(grid)
  end

  def check_cols
    check(grid.transpose)
  end

  def check_squares
    square_grid = Array.new(9) { [] }
    square_idx = ["00", "01", "02", "10", "11", "12", "20", "21", "22"]
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |elem, col_idx|
        square_num = square_idx.index("#{row_idx / 3}#{col_idx / 3}")
        square_grid[square_num] << elem
      end
    end

    check(square_grid)
  end

  def check(data)
    data.all? do |row|
      row.map(&:value).sort == RANGE
    end
  end

  def check_all
    check_rows && check_cols && check_squares
  end


end

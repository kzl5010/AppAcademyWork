class HumanPlayer
  attr_reader :name

  def initialize(name = "Bozo")
    @name = name
  end

  def guess_pos
    puts "Enter a position (row, column): "
    gets.chomp.split(",").map(&:to_i)
  end

end

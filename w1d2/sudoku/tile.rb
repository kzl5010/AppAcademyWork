require 'colorize'
require 'colorized_string'

class Tile
  attr_accessor :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def given?
    @given
  end

end

class Card
  attr_reader :value
  attr_accessor :facing_up

  def initialize(value)
    @value = value
    @facing_up = false
  end

  def hide
    @facing_up = false
  end

  def reveal
    @facing_up = true
  end

end

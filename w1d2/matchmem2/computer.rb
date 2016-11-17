class ComputerPlayer
  attr_reader :name
  attr_accessor :board

  def initialize(name = "Watson")
    @name = name
    @board = nil
    @known_cards = Hash.new { |h, k| h[k] = [] }
    @matched_cards = []
    @next_guess = nil
    @previous_guesses = []
    @pairs = nil
  end

  def guess_pos
    if @next_guess.nil?
      return_known_pairs
      if @pairs.empty?
        rand_pos
      else
        get_pair_position
      end
    else
      guess = @next_guess.dup
      @next_guess = nil
      guess
    end

  end

  def get_pair_position
    value = @pairs.keys.sample
    current_guess, @next_guess = @pairs[value]

    @previous_guesses << current_guess
    @previous_guesses << @next_guess
    @matched_cards << value
    current_guess
  end

  def return_known_pairs
    @pairs = @known_cards.select { |_, v| v.length == 2 }
    @pairs.reject! { |k, _| @matched_cards.include? k }
  end

  def rand_coordinate
    [rand(board.grid.length), rand(board.grid.first.length)]
  end

  def rand_pos
    loop do
      pos = rand_coordinate
      unless @previous_guesses.include?(pos)
        @previous_guesses << pos
        return pos
      end
    end
  end

  def received_revealed_card(position, value)
    unless @known_cards[value].include?(position)
      @known_cards[value] << position
    end
  end

end

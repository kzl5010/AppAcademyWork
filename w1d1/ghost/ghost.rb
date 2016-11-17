require "set"

class Game
  attr_reader :players, :dictionary, :current_player, :previous_player
  attr_accessor :fragment, :lost

  def initialize(players)
    @players = players
    @dictionary = Set.new(File.new("dictionary.txt", "r").readlines.map!(&:chomp))
    @fragment = String.new
    @current_player = @players[0]
    @previous_player = @players[-1]
    @lost = false
  end

  def play_round
    take_turn(@current_player)
    next_player!
  end

  def next_player!
    current_index = @players.index(@current_player)
    @current_player = @players[(current_index+1) % players.length]
    @previous_player = @players[current_index]
  end

  def take_turn(player)
    while true
      puts "The fragment is #{@fragment}"
      guess = player.guess
      if !valid_play?(guess)
        player.alert_invalid_guess
      else
        @fragment << guess
        break
      end
    end

    if dictionary.include?(@fragment)
      puts "You lose."
      @lost = true
      @current_player.record += "A"
      display_standings
    end
  end

  def display_standings
    players.each do |player|
      puts "#{player.name}'s letters are #{"GHOST"[0...player.record.length]}"
    end
  end

  def valid_play?(string)
    if !("a".."z").include?(string)
      return false
    elsif @dictionary.any? { |word| word.start_with?(@fragment + string) }
      return true
    end
    false
  end

  def run
    while true
      until lost == true
        @players.select! {|player| player.record.length < 5}
        if @players.length == 1
          puts "#{@players[0].name} wins!"
          return
        end
        play_round
      end
      @fragment = String.new
      @lost = false
    end

  end

end

class Player
  attr_reader :name
  attr_accessor :record

  def initialize(name)
    @name = name
    @record = String.new
  end

  def guess
    puts "#{self.name} Pick a letter!"
    gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid guess"
  end

end

if __FILE__ == $PROGRAM_NAME
  players = []
  while true
    puts "Enter player name or DONE to start game"
    name = gets.chomp
    break if name == "DONE"
    players << Player.new(name)
  end

  game = Game.new(players)
  game.run
end

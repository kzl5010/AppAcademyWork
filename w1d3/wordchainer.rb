require 'set'

class WordChainer
  def initialize(dictionary_path = "dictionary.txt")
    @dictionary = Set.new(File.readlines(dictionary_path).map(&:chomp))
    @current_words = []
    @all_seen_words = {}
    @new_current_words = []
  end

  def adjacent_words(word)
    adj_words = []
    0.upto(word.length - 1) do |idx|
      ("a".."z").each do |letter|
        possible_word = word.dup
        possible_word[idx] = letter
        if @dictionary.include?(possible_word)
          adj_words << possible_word unless possible_word == word
        end
      end
    end

    adj_words
  end

  def run(source, target)
    @current_words << source
    @all_seen_words[source] = nil

    until @current_words.empty?
      explore_current_words
      break if @all_seen_words.key?(target)
    end
    p build_path(target).reverse
  end

  def explore_current_words
    @new_current_words = []
    @current_words.each do |word|
      build_word_chain(word)
    end
    @current_words = @new_current_words
  end

  def build_word_chain(word)
    unseen_words = adjacent_words(word).reject do |test_word|
      @all_seen_words.include?(test_word)
    end
    unseen_words.each do |new_word|
      @new_current_words << new_word
      @all_seen_words[new_word] = word
    end
  end

  def build_path(target)
    path = [target]
    previous = @all_seen_words[target]
    until previous == nil
      path << previous
      previous = @all_seen_words[previous]
    end

    path
  end
end

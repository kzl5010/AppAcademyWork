require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(@max+1) { false }
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num) #if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num %20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if num_buckets <= @count
      resize!
    end
    self[num] << num unless include?(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num %num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_array[num % (num_buckets * 2)] << num
      end
    end
    @store = new_array
  end
end

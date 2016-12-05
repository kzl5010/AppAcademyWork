require_relative 'p02_hashing'

class HashSet
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
    @store[hashed(num) % num_buckets]
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

  def hashed(num)
    num.hash
  end
end

def range(start, stop)
  return [] if start + 1 >= stop
  [start + 1] + range(start + 1, stop)
end

def sum_array(array)
  return 0 if array.empty?
  array.first + sum_array(array[1..-1])
end

def sum_array_iter(array)
  sum = 0
  array.each { |el| sum += el }

  sum
end

def exp1(base, power)
  return 1 if power == 0
  base * exp1(base, power - 1)
end


def exp2(base, power)
  return 1 if power == 0
  if power.even?
    root = exp2(base, power / 2)
    root * root
  else
    base * exp2(base, power - 1)
  end
end

class Array
  def deep_dup
    dup_array = []
    self.each do |elem|

      if elem.is_a?(Array)
        dup_array << elem.deep_dup
      elsif elem.is_a?(Integer)
        dup_array << elem
      else
        dup_array << elem.dup
      end
    end

    dup_array
  end
end

def fibonaccir(n)
  return [] if n < 1
  return [1] if n == 1
  return [1, 1] if n == 2

  previous_fib = fibonaccir(n - 1)
  previous_fib + [previous_fib[-1] + previous_fib[-2]]
end

def fibonacciiter(n)
  return [] if n < 1
  return [1] if n == 1

  fibs = [1, 1]
  (n - 2).times do
    fibs << fibs[-1] + fibs[-2]
  end

  fibs
end

def permutations(array)
  return array if array.length == 1

  permutes = []

  array.length.times do |index|
    remaining_elements = array.dup
    permutation = remaining_elements.delete_at(index)
    smaller_permutations = permutations(remaining_elements)
    smaller_permutations.each do |small_perm|
      permutes << [[permutation] + [small_perm]].flatten
    end
  end

  permutes
end

def bsearch(array, target)
  return nil if target > array.last || target < array.first
  middle_idx = array.length / 2

  if target == array[middle_idx]
    middle_idx
  elsif target < array[middle_idx]
    bsearch(array[0...middle_idx], target)
  else
    bsearch(array[middle_idx..-1], target)
  end
end

def merge_sort(array)
  return [] if array.length <= 0
  return array if array.length == 1
  middle_idx = array.length / 2
  first_half = array[0...middle_idx]
  second_half = array[middle_idx..-1]

  merge(merge_sort(first_half), merge_sort(second_half))
end

def merge(arr1, arr2)
  merged = []
  until arr1.empty? || arr2.empty?
    merged << (arr1.first < arr2.first ? arr1.shift : arr2.shift)
  end

  merged + arr1 + arr2
end

def subsets(array)
  return [array] if array.empty?
  subsets(array[1..-1]).each_with_object([]) do |subset, all_subsets|
    all_subsets << subset.dup
    all_subsets << (subset << array[0])
  end
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0

  big_coin = coins.find { |coin| coin <= amount }
  [big_coin] + greedy_make_change(amount - big_coin, coins)
end

def make_better_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  best = nil

  coins.each do |coin|
    next if coin > amount
    remainder = amount - coin
    remaining_coins = coins.select { |other_coin| other_coin <= coin }
    solution = [coin] + make_better_change(remainder, remaining_coins)
    best = solution if best.nil? || solution.size < best.size
  end

  best
end

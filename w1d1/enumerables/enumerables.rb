class Array
  def my_each(&prc)
    0.upto(self.length-1) do |x|
      prc.call(self[x])
    end
    self
  end

  def my_select(&prc)
    arr = []
    self.my_each { |x| arr << x if prc.call(x) == true }
    arr
  end

  def my_reject(&prc)
    self - self.my_select { |x| prc.call(x) }
  end

  def my_any?(&prc)
    self.my_each do |x|
      return true if prc.call(x) == true
    end

    false
  end

  def my_all?(&prc)
    self.length == (self.my_select{ |x| prc.call(x) }).length
  end

  def my_flatten
    result = []
    self.my_each do |el|
      if el.is_a?(Array)
        el.my_flatten.each {|x| result << x}
      else result << el
      end
    end
    result
  end

  def my_zip(*args)
    results = []
    self.each_with_index do |el, idx|
      new_arr = []
      new_arr << self[idx]
      args.each do |arg|
        if arg.length < idx
          new_arr << nil
        else
          new_arr << arg[idx]
        end
      end
      results << new_arr
    end
    results
  end

  def my_rotate(rotator = 1)
    arr = self.dup
    rotator.abs.times do
      if rotator < 0
        arr.unshift(arr.pop)
      else
        arr.push(arr.shift)
      end
    end
    arr
  end

  def my_join(sep = "")
    result = String.new
    self.each do |x|
      result << x
      result << sep
    end
    result

  end

  def my_reverse
    result = []
    (0...self.length).each do |x|
      result << self[length-1-x]
    end
    result
  end

  def bubble_sort!(&prc)
    if block_given? == false
      prc = Proc.new { |num1, num2| num1 <=> num2 }
    end

    while true
      swaps = false
      0.upto(self.length-2) do |idx|
        if prc.call(self[idx], self[idx+1]) == 1
          swaps = true
          self[idx+1], self[idx] = self[idx], self[idx+1]
        end
      end
      break if swaps == false
    end
    self
  end

  def bubble_sort(&prc)
    if block_given? == false
      prc = Proc.new { |num1, num2| num1 <=> num2 }
    end

    self.dup.bubble_sort!{|x| prc.call(x)}
  end

end

def factors(num)
  result = []
  1.upto(num) do |x|
    result << x if num % x == 0
  end
  result
end

def substrings(str)
  result = []
  0.upto(str.length - 1) do |x|
    x.upto(str.length - 1) do |y|
      result << str[x..y]
    end
  end
  result
end

def subwords(str, dictionary)
  result = []
  substrings(str).each do |substr|
    result << substr if dictionary.include?(substr) && !result.include?(substr)
  end
  result
end

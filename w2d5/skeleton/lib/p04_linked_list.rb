class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, next_elem = nil, prev = nil)
    @key = key
    @val = val
    @next = next_elem
    @prev = prev
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

  def initialize
    @head = Link.new("Sentinel", "Sentinel")
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail
  end

  def empty?
    @head == @tail && head.val == "Sentinel"
  end

  def get(key)
    current_node = @head.next
    loop do
      return current_node.val if current_node.key == key
      break if current_node.next.nil?
      current_node = current_node.next
    end

    nil
  end

  def include?(key)
    current_node = @head.next
    loop do
      return true if current_node.key == key
      break if current_node.next.nil?
      current_node = current_node.next
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val, nil, @tail)
    @tail.next = new_link
    @tail = new_link
  end

  def update(key, val)
    current_node = @head.next
    return if current_node.nil?

    loop do
      break if current_node.next.nil?
      break if current_node.key == key
      current_node = current_node.next
    end

    if current_node.key == key
      current_node.val = val
    end
  end

  def remove(key)
    current_node = @head.next
    return if current_node.nil?

    loop do
      break if current_node.next.nil?
      break if current_node.key == key
      current_node = current_node.next
    end

    if current_node.key == key
      current_node.next.prev = current_node.prev
      current_node.prev.next = current_node.next
    end

  end

  def each(&prc)
    current_node = @head.next
    return if current_node.nil?

    loop do
      prc.call(current_node)
      break if current_node.next.nil?
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

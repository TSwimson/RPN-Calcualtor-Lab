# The stack should be implemented using a linked list.
# Do not use any ruby arrays!!
class Node
  attr_accessor :next_node, :previous, :value
  
  def initialize(value)
    @value = value
  end
end

class Stack
  attr_reader :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def <<(value)
    push(value)
  end
  # Adds a new value to the end of the list.
  def push(value)
    if @tail != nil
      @tail.next_node = Node.new(value)
      @tail.next_node.previous = @tail
      @tail = @tail.next_node
    else
      @tail = Node.new(value)
      if @head == nil
        @head = @tail
      end
    end
    @length += 1
    nil
  end

  # Returns the value that is popped off
  # or nil if none exists
  def pop
    if @tail != nil
      ret = @tail
      @tail = @tail.previous
      if @tail != nil
        @tail.next_node = nil
      end
      @length -= 1
      if @head == ret
        @head = nil
      end
      return ret.value
    elsif @head
      ret = @head
      @head = nil
      @length -= 1
      return ret.value
    else
      return nil
    end
  end
end

class List
  attr_reader :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end
  def <<(v)
    push(v)
  end
  # Adds a new value to the end of the list.
  def push(value)
    if @tail != nil
      @tail.next_node = Node.new(value)
      @tail.next_node.previous = @tail
      @tail = @tail.next_node
    else
      @tail = Node.new(value)
      if @head == nil
        @head = @tail
      end
    end
    @length += 1
    nil
  end

  # Returns the value that is popped off
  # or nil if none exists
  def pop
    if @tail != nil
      ret = @tail
      @tail = @tail.previous
      if @tail != nil
        @tail.next_node = nil
      end
      @length -= 1
      if @head == ret
        @head = nil
      end
      return ret.value
    elsif @head
      ret = @head
      @head = nil
      @length -= 1
      return ret.value
    else
      return nil
    end
  end

  def insert(index, value)
    if index >= @length
      push(value)
      return value
    end
    if @tail != nil
      node = get_node_at_index(index)
      insert_node = Node.new(value)
      insert_node.next_node = node
      if node != nil
        insert_node.previous = node.previous
        node.previous.next_node = insert_node
        node.previous = insert_node
      end
      if @head == node
        @head = insert_node
      end
      @length += 1
    else
      push(value)
    end
  end

  def to_s
    str = []
    each { |i| str << i }
    return str.join(", ")
  end
  # Given an index, returns the value at that index
  def [](index)
    ret = get_node_at_index(index)
    return ret.value if ret != nil
    return ret
  end

  # Sets a value at the given index.  Returns the value that
  # was assigned
  def []=(index, value)
    node = get_node_at_index(index)
    node.value = value
    node.value
  end

  # Returns the first value that was removed from the list and
  # shifts all items down by 1
  def shift
    return nil if @head == nil
    ret = @head
    @head = @head.next_node if @head != nil
    @head.previous = nil
    return ret.value
  end

  # Adds a new value to the front of the list
  def unshift(value)
    if @head != nil
      new_head = Node.new(value)
      @head.next_node = new_head
      new_head.previous = @head
      @head = new_head
    else
      push(value)
    end
  end

  def first
    return @head.value
  end

  def last
    return @tail.value
  end

  def each
    i = 0
    current_node = @head
    while i < @length
      yield current_node.value
      current_node = current_node.next_node
      i += 1
    end
  end

  def min
    min = self[0]
    each do |i|
      if i.class == Fixnum || i.class == Bignum
        min = i if i < min
      else
        return nil
      end
    end
    return min
  end

  def max
    max = self[0]
    each do |i|
      if i.class == Fixnum || i.class == Bignum
        max = i if i > max
      else
        return nil
      end
    end
    return max
  end
  private

  def get_node_at_index(index)
    return nil if index < 0 || index > length - 1
    distance_from_tail = @length - index
    if distance_from_tail < index
      i = @length
      current_node = @tail
      while i >= 0
        return current_node if i == index + 1
        current_node = current_node.previous
        i -= 1
      end
    else
      i = 0
      current_node = @head
      while i <= length
        return current_node if i == index
        current_node = current_node.next_node
        i += 1
      end
    end
  end
end

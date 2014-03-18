require './stack.rb'
# Do not use a ruby array!  Add your list class instead

class RPNCalculator
  # Parse should return a list class that you defined, not a ruby array
  def self.parse(rpn_string)
    expressions = List.new
    rpn_string.split(" ").each { |c| expressions << c }
    return expressions
  end

  def self.evaluate(rpn_list)
    numbers = Stack.new
    expressions = Stack.new
    rpn_list.each do |e|
      if is_operation(e)
        first = numbers.pop
        second = numbers.pop
        e = '**' if e == '^'
        numbers << second.send(e, first)
      elsif is_number(e)
        numbers << e.to_f
      end
    end
    return numbers.pop
  end

  def self.is_operation(op)
    (/\A[+-\/\*\^]\z/ =~ op) != nil
  end
  
  def self.is_number(num)
    ((/\A-?\d+\z/ =~ num) != nil)
  end
end

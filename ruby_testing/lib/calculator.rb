class Calculator
  def add(*numbers)
    numbers.sum
  end
  def multiply(*numbers)
    numbers.inject(:*)
  end
end

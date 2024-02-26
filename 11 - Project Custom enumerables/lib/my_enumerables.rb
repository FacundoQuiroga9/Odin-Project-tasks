module Enumerable
  def my_each
    return to_enum(__method__) unless block_given?

    for item in self
      yield(item)
    end

    self
  end

  def my_each_with_index
    return to_enum(__method__) unless block_given?

    index = 0

    my_each do |item|
      yield(item, index)
      index += 1
    end

    self
  end

  def my_select
    return to_enum(__method__) unless block_given?
    result = []

    my_each do |item|
      result << item if yield(item)
    end

    result
  end

  def my_all?
    return true if empty?

    my_each do |item|
      return false unless yield(item)
    end

    true
  end

  def my_any?
    my_each do |item|
      return true if yield(item)
    end

    false
  end

  def my_none?
    my_each do |item|
      return false if yield(item)
    end

    true
  end

  def my_count(arg = nil)
    count = 0

    if block_given?
      my_each { |item| count += 1 if yield(item) }
    elsif arg.nil?
      my_each { count += 1 }
      my_each { |item| count += 1 if item == arg }
    end

    count
  end

  def my_map
    result = []

    if block_given?
      my_each { |item| result << yield(item) }
    else
      return to_enum(:my_map) unless block_given?
    end

    result
  end

  def my_inject(initial = nil)
    accumulator = initial || first

    my_each_with_index do |item, index|
      next if index.zero? && initial.nil?

      accumulator = yield(accumulator, item)
    end

    accumulator 
  end

end
#------------------------------------------------------------------------------------------------------------------------------------------------------------
class Array
  def my_each(&block)
    return to_enum(__method__) unless block_given?

    for item in self
      block.call(item)
    end

    self
  end

end

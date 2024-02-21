def bubble_sort(array)
  array_length = array.length

  (array_length - 1).times do |i|
    
    (array_length - 1 - i).times do |j|
      if array[j] > array[j + 1]
        array[j], array[j + 1] = array[j + 1], array[j]
      end
    end
  end

 p array
end


bubble_sort([4, 3, 78, 2, 0, 2])

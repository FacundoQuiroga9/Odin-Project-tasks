def merge_sort(arr)
  return arr if arr.length <= 1


  mid = arr.length / 2
  left_half = arr[0...mid]
  right_half = arr[mid..]

  left_sorted = merge_sort(left_half)
  right_sorted = merge_sort(right_half)

  merge(left_sorted, right_sorted)
end

def merge(left, right)
  merged = []
  until left.empty? || right.empty?
    if left.first <= right.first
      merged << left.shift
    else
      merged << right.shift
    end
  end
  merged.concat(left).concat(right)
end

arr1 = [3, 2, 1, 13, 8, 5, 0, 1]
arr2 = [105, 79, 100, 110]

p merge_sort(arr1)
p merge_sort(arr2)

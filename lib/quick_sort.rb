require 'byebug'
class Array
  def swap(i,j)
    self[i], self[j] = self[j], self[i]
  end
end

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array[rand(array.length)]
    left, right = array.partition { |el| el < pivot}
    left_sort, right_sort = QuickSort.sort1(left), QuickSort.sort1(right)
    left_sort + [pivot] + right_sort
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= proc { |x,y| x <=> y }
    idx = partition(array, start, length, &prc)
    left_len = idx - start
    right_len = length - (left_len + 1)
    sort2!(array, start, left_len, &prc)
    sort2!(array, idx+1, right_len, &prc)
  end
  
  def self.partition(array, start, length, &prc)
    prc ||= proc { |x,y| x <=> y }

    pivot = array[start]
    boundary = start 
    ((start+1)...(start+length)).each do |i|
      
      if prc.call(pivot, array[i]) > 0
        
        array.swap(boundary+1,i)
        boundary += 1
      end
    end
    array.swap(boundary, start)
    boundary
  end
end
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def sub_strings_counter(string, dictionary)
  result = Hash.new(0)
  array_string = string.downcase.split(" ")
  array_string.each do |word|
   if dictionary.each.include?(word)
    result[word] += 1
   end
  end
  p result
end

sub_strings_counter("below go home going horn carrot horn", dictionary)

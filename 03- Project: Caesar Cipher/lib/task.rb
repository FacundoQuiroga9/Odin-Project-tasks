def caesar_cipher(phrase, number)
  alphabet = ("a".."z").to_a
  array_phrase = phrase.downcase.split("")
  result = []
  array_phrase.each do |letter|
    if alphabet.include?(letter)
      new_index = alphabet.index(letter) - number
      result << alphabet[new_index]
    else
      result << letter
    end
  end

p result.join("")
end

caesar_cipher("hello, world!", 5)

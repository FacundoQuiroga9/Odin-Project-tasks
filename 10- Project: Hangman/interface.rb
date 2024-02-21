require_relative 'hangman'

puts "Would you like to start a new game or load a saved game? (new/load)"
choice = gets.chomp.downcase

if choice == 'new'
  game = Hangman.new
  game.play
elsif choice == 'load'
  puts "Enter filename to load game:"
  filename = gets.chomp
  game = Hangman.load_game(filename)
  game.play
else
  puts "Invalid choice. Please enter 'new' or 'load'."
end

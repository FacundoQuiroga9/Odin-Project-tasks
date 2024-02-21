require 'json'

class Hangman
  attr_accessor :secret_word, :guessed_letters, :incorrect_guesses, :game_over

  def initialize
    @words = File.readlines('google-10000-english-no-swears.txt').map(&:chomp).select { |word| word.length >= 5 && word.length <= 12 }
    @secret_word = @words.sample.downcase
    @guessed_letters = []
    @incorrect_guesses = 0
    @max_incorrect_guesses = 6
    @game_over = false
  end

  def display_word
    display = ''
    @secret_word.chars.each do |letter|
      if @guessed_letters.include?(letter)
        display += letter
      else
        display += '_'
      end
      display += ' '
    end
    display
  end

  def display_guessed_letters
    @guessed_letters.join(', ')
  end

  def guess(letter)
    if @secret_word.include?(letter)
      @guessed_letters << letter unless @guessed_letters.include?(letter)
    else
      @incorrect_guesses += 1
    end
  end

  def check_game_over
    if @incorrect_guesses >= @max_incorrect_guesses
      puts "Game over! The word was: #{@secret_word}"
      @game_over = true
    elsif @secret_word.chars.all? { |letter| @guessed_letters.include?(letter) }
      puts "Congratulations! You guessed the word: #{@secret_word}"
      @game_over = true
    end
  end

  def save_game(filename)
    game_data = {
    secret_word: @secret_word,
    guessed_letters: @guessed_letters,
    incorrect_guesses: @incorrect_guesses,
    game_over: @game_over
  }
    File.open(filename, 'w') do |file|
      file.puts JSON.dump(game_data)
    end
    puts "Game saved successfully as #{filename}"
  end

  def self.load_game(filename)
    serialized_game = File.read(filename)  # Leemos el contenido del archivo
    game_data = JSON.parse(serialized_game)  # Deserializamos la cadena JSON en un objeto Ruby
    game = Hangman.new  # Creamos una nueva instancia de Hangman
    game.secret_word = game_data["secret_word"]
    game.guessed_letters = game_data["guessed_letters"]
    game.incorrect_guesses = game_data["incorrect_guesses"]
    game.game_over = game_data["game_over"]
    puts "Game loaded successfully from #{filename}"
    return game
  rescue StandardError => e
    puts "Error loading game: #{e.message}"
    return nil
  end

  def play
    puts "Welcome to Hangman!"
    until @game_over
      puts "Word: #{display_word}"
      puts "Guessed letters: #{display_guessed_letters}"
      puts "Incorrect guesses remaining: #{@max_incorrect_guesses - @incorrect_guesses}"

      puts "Enter a letter to guess, or type 'save' to save the game:"
      guess = gets.chomp.downcase

      if guess == 'save'
        puts "Enter filename to save game:"
        filename = gets.chomp
        save_game(filename)
        break
      elsif guess.length != 1 || !guess.match?(/[a-z]/)
        puts "Please enter a single letter from a-z."
        next
      end

      guess(guess)
      check_game_over
    end
  end
end

# Main program

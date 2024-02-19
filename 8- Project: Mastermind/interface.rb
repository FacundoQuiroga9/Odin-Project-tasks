require_relative "mastermind"


  game = Mastermind.new
  turns_left = 12

  puts "Welcome to Mastermind!"
  puts "Guess the secret code in 12 turns."
  puts "Enter your guess (e.g., red green blue yellow):"

  loop do
    puts "You have #{turns_left} turns left."
    guess = gets.chomp.split

    exact_matches, color_matches = game.check_guess(guess)

    if exact_matches == 4
      puts "Congratulations! You guessed the secret code!"
      break
    else
      puts "Feedback: #{exact_matches} exact matches and #{color_matches} color matches."
    end

    turns_left -= 1
    if turns_left == 0
      puts "Game over! You ran out of turns. The secret code was #{game.secret_code.join(', ')}."
      break
    end
  end

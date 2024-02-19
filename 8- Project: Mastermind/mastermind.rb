class Mastermind
  COLORS = ["red", "green", "blue", "yellow", "orange", "purple"]

  attr_reader :secret_code

  def initialize
    @secret_code = generate_secret_code
  end

  def check_guess(guess)
    exact_matches = 0
    color_matches = 0

    guess.each_with_index do |color, index|
      if color == secret_code[index]
        exact_matches += 1
      elsif secret_code.include?(color)
        color_matches += 1
      end
    end

    [exact_matches, color_matches]
  end

  private

  def generate_secret_code
    secret_code = []
    4.times { secret_code << COLORS.sample }
    secret_code
  end
end

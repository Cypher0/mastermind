# Class for the human player
class Human
  attr_accessor :code, :guess, :feedback

  #   Set up the player with variables for a guess and code,
  # and an array for giving feedback
  def initialize
    @guess = ''
    @code = ''
    @feedback = %w(x x x x)
  end

  # Prompt the user for a valid guess of the code
  def try_to_guess(*)
    puts 'Try to guess the code!:'
    input = gets.chomp
    if input.size == 4 && input.chars.map(&:to_i).all? { |d| d.between?(1, 6) }
      @guess = input
    else
      puts 'This is not a valid guess, try again!'
      try_to_guess
    end
  end

  # Automatically give correct feedback on the computer's guess
  def give_feedback(guess)
    @feedback = []
    temp_code = @code.chars.map(&:to_i)
    guess.chars.map(&:to_i).each_with_index do |val, ind|
      if val == temp_code[ind]
        @feedback << '!'
        temp_code[ind] = 'X'
      elsif temp_code.include?(val)
        @feedback << '?'
      else
        @feedback << '0'
      end
    end
    puts "The computer gets feedback: #{@feedback.join}"
  end

  # Prompt the user to create a valid code for the computer to break
  def generate_code
    puts 'Create a code and see if the computer can break it!'
    puts 'The code is a number containing four digits, each between 1 and 6.'
    input = gets.chomp
    if input.chars.map(&:to_i).all? { |i| i.between?(1, 6) } && input.size == 4
      @code = input
    else
      puts 'This is not a valid code, try again!'
      generate_code
    end
  end
end

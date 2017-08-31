# Class for the computer player
class Computer
  attr_accessor :guess, :code, :sample, :feedback

  #   Sets up the player with variables for a guess and code, an array 
  # for giving feedback and a sample array for eliminating numbers to guess
  def initialize
    @guess = ''
    @code = ''
    @feedback = Array.new(4)
    @sample = *(1..6)
  end

  # Automatically give correct feedback on the user's guess
  def give_feedback(guess)
    @feedback = []
    temp_code = @code.chars.map(&:to_i)
    guess.chars.map(&:to_i).each_with_index do |val, ind|
      if val == temp_code[ind]
        @feedback << '!'
        temp_code[ind] = 'X'
      elsif temp_code.include?(val)
        @feedback << '?'
        temp_code[temp_code.index(val)] = 'X'
      else
        @feedback << '0'
      end
    end
    puts @feedback.join
  end

  #   Automatically generate a code using feedback from the previous guess.
  # (Generates a random code on the first turn/if no feedback given.)
  def try_to_guess(feedback = %w(x x x x))
    feedback.each_with_index do |val, ind|
      if val == '!'
        next
      elsif val == '0' && !feedback.include?('?')
        @sample.delete(@guess[ind].to_i)
        @guess[ind] = @sample.sample.to_s
      else
        @guess[ind] = @sample.sample.to_s
      end
    end
    puts "The computer guesses #{@guess}."
  end

  # Generate a random code for the user to guess
  def generate_code
    puts 'Welcome to Mastermind!'
    4.times do
      @code += rand(1..6).to_s
    end
    puts 'The secret code is a 4-digit number containing digits from 1 to 6.'
    puts 'The computer will give you feedback on your guess:'
    puts "'!' means a correct number in the correct position."
    puts "'?' means a correct number, but in the wrong position."
    puts "'0' means that this number is not in the code."
  end
end

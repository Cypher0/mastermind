class Game
  def initialize
    @number_of_turns = 0
  end

  def setup_players
    puts 'Do you want to (M)ake or (B)reak the code?'
    answer = gets.chomp
    if answer.downcase == 'm'
      @maker = Human.new
      @breaker = Computer.new
    elsif answer.downcase == 'b'
      @breaker = Human.new
      @maker = Computer.new
    else
      puts "I didn't understand that, please try again."
      setup_players
    end
  end

<<<<<<< HEAD
  def begin
    setup_players
    @maker.generate_code
    until @number_of_turns == 12 || @breaker.guess == @maker.code
      @breaker.try_to_guess(@maker.feedback)
      @maker.give_feedback(@breaker.guess)
      @number_of_turns += 1
    end
    finish_game
  end
=======
	def begin
		puts "Welcome to Mastermind!"
		@cpu.generate_code
		puts "The secret code is a 4-digit number containing digits from 1 to 6."
		puts "The computer will give you feedback on your guess:"
		puts "'!' means a correct number in the correct position."
		puts "'?' means a correct number, but in the wrong position."
		puts "'0' means that this number is not in the code."
		until @number_of_turns == 12 || @human.guess == @cpu.code do
			@human.try_to_guess
			if @human.guess.length == 4
				@cpu.give_feedback(@human.guess)
				@number_of_turns += 1
			else
				puts "Make sure your guess has 4 digits!"
				redo
			end
		end
		if @human.guess == @cpu.code
			puts "Congratulations, you guessed the secret code with #{@number_of_turns} turns!"
		else
			puts "Sorry, you failed to guess the secret code."
			puts "The correct answer was #{@cpu.code}."
		end
	end
>>>>>>> c956ea7c72f2fb074accd57b74f9d0208009214c

  def finish_game
    if @breaker.guess == @maker.code
      puts "Correct! The code was broken in #{@number_of_turns} turns!"
      puts 'Codebreaker wins!'
    else
      puts 'Game over, Codebreaker failed to break the code!'
      puts "The correct answer was #{@maker.code}."
      puts 'Codemaker wins!'
    end
  end
end

class Computer
  attr_accessor :guess, :code, :sample, :feedback

  def initialize
    @guess = ''
    @code = ''
    @feedback = Array.new(4)
    @sample = *(1..6)
  end

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
end

class Human
  attr_accessor :code, :guess, :feedback

  def initialize
    @guess = ''
    @code = ''
    @feedback = %w(x x x x)
  end

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
end

<<<<<<< HEAD
Game.new.begin
=======
game = Game.new
game.begin
>>>>>>> c956ea7c72f2fb074accd57b74f9d0208009214c

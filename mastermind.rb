class Game

	def initialize
		@number_of_turns = 0
		@human = CodeBreaker.new
		@cpu = CodeMaker.new
	end

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

end

class CodeMaker
	attr_accessor :code

	def initialize
		@code = ""
		@feedback = []
	end

	def generate_code
		4.times do
			@code += rand(1..6).to_s
		end
	end

	def give_feedback(guess)
		@feedback = []
		temp_code = @code.chars.map(&:to_i)
		guess.chars.map(&:to_i).each_with_index do |val, ind|
			if val == temp_code[ind]
				@feedback << "!"
				temp_code[ind] = "X"
			elsif temp_code.include?(val)
				@feedback << "?"
				i = temp_code.index(val)
				temp_code[i] = "X"
			else
				@feedback << "0"
			end
		end
		puts @feedback.join
	end

end

class CodeBreaker
	attr_accessor :guess

	def initialize
		@guess = ""
	end

	def try_to_guess
		puts "Try to guess the code!:"
		@guess = gets.chomp
	end

end

game = Game.new
game.begin

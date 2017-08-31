require 'sinatra'
require 'sinatra-contrib'
require_relative 'lib/human.rb'
require_relative 'lib/computer.rb'

# Class for creating and executing the game
class Game

  # Set up the game with a variable counting the number of turns
  def initialize
    @number_of_turns = 0
  end

  # Create and set up the players
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

  # Loop the game until code is broken or turns are used
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

  # Print the results of the game
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

Game.new.begin

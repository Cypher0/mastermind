require 'sinatra'
require 'sinatra/reloader' if development?

configure do
  enable :sessions
end

def gen_code
  code = ''
  4.times { code += "#{rand(1..6).to_s}"}
  code
end

def give_feedback(guess, code)
  result = '0000'
  temp_code = code.split('')
  guess.split('').each_with_index do |val, ind|
    if val == temp_code[ind]
      result[ind] = '!'
      temp_code[ind] = 'X'
    end
  end
  guess.split('').each_with_index do |val, ind|
    next if result[ind] == '!'
    if temp_code.include?(val)
      result[ind] = '?'
      temp_code[temp_code.index(val)] = 'X'
    end
  end
  result
end

def eval_guess(guess, feedback)
  session[:rem_guesses] -= 1
  if guess.nil? || session[:code].nil?
    ''
  elsif guess == session[:code]
    session[:code] = nil
    "Congratulations, you cracked the code! A new code was generated."
  elsif session[:rem_guesses].zero?
    session[:code] = nil
    "Out of turns! You failed to crack the code. A new code was generated."
  else
    "Keep trying! #{session[:rem_guesses]} turns left."
  end
end

get '/' do
  redirect '/new' if session[:code].nil?
  erb :index, :locals => {:guesses => session[:guesses], :feedbacks => session[:feedbacks], :message => session[:message]}
end

post '/' do
  @guesses = session[:guesses]
  @feedbacks = session[:feedbacks]
  guess = params[:guess]
  feedback = give_feedback(guess, session[:code])
  @guesses << guess
  @feedbacks << feedback
  session[:message] = eval_guess(guess, feedback)
  redirect '/'
end

get '/new' do
  session[:code] = gen_code
  session[:rem_guesses] = 12
  session[:guesses] = []
  session[:feedbacks] = []
  redirect '/'
end

get '/rules' do
  erb :rules
end

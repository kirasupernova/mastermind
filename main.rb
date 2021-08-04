require_relative 'mastermind_module'
require_relative 'mastermind'
require_relative 'player'
require_relative 'computer'

def intro
  puts "WELCOME TO MASTERMIND!\n"
  puts MastermindRound.explain
  puts MastermindRound.rules
  puts 'Would you like to play? Y/N'
  begin
    continue
  rescue StandardError => e
    puts e.message
    retry
  end
end

def continue
  answer = gets.chomp.downcase
  if answer == 'n'
    exit
  elsif answer != 'n' && answer != 'y'
    raise StandardError.new, 'Please answer with Y (yes) or N (no).'
  end
end

def initiate
  print 'Please enter your name: '
  name = gets.chomp
  puts "#{name}, would you like to be codemaker or codebreaker?"
  begin
  role = gets.chomp.downcase
  if role == 'codemaker' || role == 'codebreaker'
    continue_as(name, role)
  else
    raise StandardError.new, 'Check your spelling and try again!'
  end
  rescue StandardError => e
    puts e.message
    retry
  end
end

def continue_as(name, role)
  codemaker = nil
  codebreaker = nil
  case role
  when 'codebreaker'
    codebreaker = Player.new(name)
    codemaker = Computer.new
  when 'codemaker'
    codebreaker = Computer.new
    codemaker = Player.new(name)
  end
  play(codemaker, codebreaker)
end

def play(codemaker, codebreaker)
  print "#{codemaker.name}, set your secret code:"
  mastermind = MastermindRound.new(codemaker.set_code)
  until mastermind.won? || mastermind.guesses.length == 12
    print "Guess #{mastermind.guesses.length + 1}: "
    guess = codebreaker.guess
    mastermind.place(guess)
    feedback = mastermind.check
    codebreaker.eval(feedback)
    puts ' '
  end
  win_lose_message(mastermind, codemaker, codebreaker)
end

def win_lose_message(mastermind, codemaker, codebreaker)
  if mastermind.won?
    puts "Congratulations, #{codebreaker.name}! You cracked the code!"
  else
    puts "Sorry, you're out of turn to break #{codemaker.name}'s code! Better luck next time, #{codebreaker.name}!"
  end
end

intro
initiate

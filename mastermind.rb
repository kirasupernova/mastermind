# frozen_string_literal: true
# SETUP
# MASTERMIND-GAME class (instance holds explanation, rules, layout, secret code, previous guesses, responses, method for responding)
# COMPUTER class (holds methods for randomly generating possibilities, setting secret code, guessing)
# PLAYER class (holds methods for accepting secret code, guesses, name variable)
# instantiate method will generate computer class and player class
# instantiate method will ask player if they want to be codemaker or codebreaker and Mastermind.new(codemaker, codebreaker)
# play method will ask codemaker for code and then accept codebreaker's responses

module Mastermind

  EXPLANATION = "Mastermind or Master Mind is a code-breaking game for two players.\n"\
"The modern game, which is usually played with pegs, was invented in 1970 by Mordecai Meirowitz,\n"\
"an Israeli postmaster and telecommunications expert.\n\n"\
"In this version, the colored pegs a represented by numbers 1-6.\n\n"

  RULES = "1. The codemaker can set the code to any possible combination of four numbers,\n"\
  "   including duplicates.\n"\
  "2. The codebreaker gets twelve attempts at breaking the code.\n"\
  "3. After each guess, the codebreaker will receive feedback like so:\n"\
  "   X O - -\n"\
  "   The O indicates one guess is correct but in the wrong position, while the X\n"\
  "   represents a guess that is both correct AND in the correct position.\n"\
  "   Each wrong guess is represented by -. The position of the feedback does not\n"\
  "   necessarily correlate with its position in the code.\n"

  def all_possibilities
    [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a
  end

  def give_feedback(code, guess)
    feedback = []
    guess.each_with_index do |num, index|
      if num == code[index]
        feedback.push('X')
      elsif code[index..-1].include?(num)
        feedback.push('O')
      else
        feedback.push('-')
      end
    end
    feedback.sort.reverse
  end
end

class MastermindRound
  include Mastermind

  attr_reader :guesses, :secret_code

  def initialize(secret_code)
    @secret_code = secret_code
    @guesses = []
    @board = []
  end

  def self.explain
    EXPLANATION
  end

  def self.rules
    RULES
  end

  def place(guess)
    self.guesses.push(guess)
  end

  def won?
    guesses[-1] == @secret_code
  end
end

class Player
  
  attr_reader :name

  def initialize(name)
    @name = name
    @last_guess = nil
    @last_feedback = nil
  end

  def validate_input(input)
    if input.length == 4 && input.split('').all? { |el| el.to_i.between?(1, 6) }
      input.split('').map(&:to_i)
    else
      raise StandardError.new, "Invalid input! Please enter a four digit code with numbers from 1-6 like so: '1234'!"
    end
  end

  def set_code
    input = gets.chomp
    validate_input(input)
  rescue StandardError => e
    puts e.message
    retry
  end

  def guess
    set_code
  end
end

class Computer < Player
  include Mastermind

  attr_accessor :knuth_s, :last_guess, :last_feedback

  def initialize(name)
    super(name)
    @knuth_s = self.all_possibilities
  end

  def set_code
    4.times do
      print ' *'
      sleep(1)
    end
    puts ' Done!'
    sleep(1)
    self.all_possibilities.sample
  end

  def eval(feedback)
    self.last_feedback = feedback
    self.knuth_s = self.knuth_s.filter { |poss| give_feedback(poss, self.last_guess) == feedback }
  end

  def guess
   return self.last_guess = if !last_guess
                        knuth_s.delete([1, 1, 2, 2])
                      else
                        knuth_s.shift
                      end
   puts self.last_guess
  end
end

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
  print "Please enter your name: "
  name = gets.chomp
  puts "#{name}, would you like to be codemaker or codebreaker?"
  role = gets.chomp.downcase
  begin
  if role == 'codemaker' || role == 'codebreaker'
  else
    raise StandardError.new, 'Check your spelling and try again!'
  end
  rescue StandardError => e
    puts e.message
  end
  play(name, role)
end

def play(name, role)
  codemaker = nil
  codebreaker = nil
  case role
  when 'codebreaker'
    codebreaker = Player.new(name)
    codemaker = Computer.new('Computer')
  when 'codemaker'
    codebreaker = Computer.new('Computer')
    codemaker = Player.new(name)
  end
  print "#{codemaker.name}, set your secret code:"
  mastermind = MastermindRound.new(codemaker.set_code)
  until mastermind.won? || mastermind.guesses.length == 12
    print "Guess #{mastermind.guesses.length + 1}: "
    mastermind.place(codebreaker.guess)
    puts "Feedback: #{mastermind.give_feedback(mastermind.secret_code, mastermind.guesses[-1]).join(' ')}"
  end
end

intro
initiate
# TODO: write player class
#     write play method
#     write win method for MastermindRound

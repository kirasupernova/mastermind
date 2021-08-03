module Mastermind
  EXPLANATION = "Mastermind or Master Mind is a code-breaking game for two players.\n"\
"The modern game, which is usually played with pegs, was invented in 1970 by Mordecai Meirowitz,\n"\
"an Israeli postmaster and telecommunications expert.\n\n"\
"In this version, the colored pegs are represented by numbers 1-6.\n\n"

  RULES = "1. The codemaker can set the code to any possible combination of four numbers,\n"\
  "   including duplicates.\n"\
  "2. The codebreaker gets twelve attempts at breaking the code.\n"\
  "3. After each guess, the codebreaker will receive feedback like so:\n"\
  "   X O - -\n"\
  "   The O indicates one guess is correct but in the wrong position, while the X\n"\
  "   represents a guess that is both correct AND in the correct position.\n"\
  "   Each wrong guess is represented by -. The position of the feedback does not\n"\
  "   necessarily correlate with its position in the code.\n"\
  "4. To avoid cheating, if you chose to be the codemaker, you will not be able to give\n"\
  "   feedback - it will happen automatically."

  def all_possibilities
    [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a
  end 

  def give_feedback(code, guess)
    feedback = []
    unused_code = code
    unused_guess = guess
    guess.each_with_index do |num, index|
      if num == code[index]
        feedback.push('X')
        unused_code = unused_code.reject.with_index { |_el, ind| ind == unused_code.index(num) }
        unused_guess = unused_guess.reject.with_index { |_el, ind| ind == unused_guess.index(num) }
      end 
    end 
    unused_guess.each do |num|
      if unused_code.include?(num)
        feedback.push('O')
        unused_code = unused_code.reject.with_index { |_el, ind| ind == unused_code.index(num) }
      else
        feedback.push('-')
      end 
    end 
    feedback.sort.reverse
  end 
end


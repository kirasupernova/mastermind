class MastermindRound
  include Mastermind

  private

  attr_reader :secret_code

  public

  attr_reader :guesses

  def initialize(secret_code)
    @secret_code = secret_code
    @guesses = []
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

  def check
    self.give_feedback(self.secret_code, self.guesses[-1])
  end

  def won?
    guesses[-1] == @secret_code
  end
end


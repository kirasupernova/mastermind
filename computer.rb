class Computer
  include Mastermind

  private

  attr_accessor :last_guess, :knuth_s

  public

  attr_accessor :name

  def initialize
    @name = 'Computer'
    @knuth_s = self.all_possibilities
    @last_guess = nil
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
    print 'Feedback: '
    sleep(1)
    puts feedback.join(' ')
    self.knuth_s = self.knuth_s.filter { |poss| self.give_feedback(self.last_guess, poss) == feedback }
  end

  def guess
    sleep(1)
    if !last_guess
      puts "1122"
      self.last_guess = knuth_s.delete([1, 1, 2, 2])
    else
      puts knuth_s[0].join
      self.last_guess = knuth_s.shift
    end
  end
end


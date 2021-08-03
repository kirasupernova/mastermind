class Player

  attr_reader :name

  def initialize(name)
    @name = name
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

  def eval(feedback)
    print 'Feedback: '
    puts feedback.join(' ')
  end

  private

  def validate_input(input)
    if input.length == 4 && input.split('').all? { |el| el.to_i.between?(1, 6) }
      input.split('').map(&:to_i)
    else
      raise StandardError.new, "Invalid input! Please enter a four digit code with numbers from 1-6 like so: '1234'!"
    end
  end

end


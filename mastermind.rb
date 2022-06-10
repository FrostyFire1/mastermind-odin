class Player
  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @maker_guesses = 0
    @breaker_guesses = 0
  end
end

class Computer < Player
  def initialize
    name = ["Saul Bitman", "Ternary Tristan", "Octal John","Marcus Loopius"].sample
    super(name)
  end
end



cpu = Computer.new

p cpu




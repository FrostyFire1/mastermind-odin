class Player
  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @maker_guesses = 0
    @breaker_guesses = 0
    @available_colors = %w[red green yellow orange blue purple]
  end
end

class Computer < Player
  def initialize
    name = ['Saul Bitman', 'Ternary Tristan', 'Octal John', 'Marcus Loopius'].sample
    super(name)
  end

  def random_color
    @available_colors.sample
  end
end

class Game
  def initialize(code_maker, code_breaker, max_guesses = 10)
    @code_maker = code_maker
    @code_breaker = code_breaker
    @maker_colors = []
    @max_guesses = max_guesses
  end

  def start_game
    set_maker_colors
    breaker_play
  end
end

cpu = Computer.new

p cpu

puts cpu.guess_color
class Player
  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @maker_guesses = 0
    @breaker_guesses = 0
  end

  def play(color_list)
    puts 'Player chose nothing.'
  end
end

class Computer < Player
  def initialize
    name = ['Saul Bitman', 'Ternary Tristan', 'Octal John', 'Marcus Loopius'].sample
    super(name)
  end

  def play(color_list)
    color_list.sample
  end
end

class Game
  def initialize(code_maker, code_breaker, max_guesses = 10)
    @code_maker = code_maker
    @code_breaker = code_breaker
    @maker_colors = []
    @max_guesses = max_guesses
    @available_colors = %w[red green yellow orange blue purple]
  end

  def start_game
    set_maker_colors
    breaker_play
  end

  private 

  def set_maker_colors(remaining = 4, current = 1)
    return if remaining.zero?

    puts "Please pick color ##{current}. Available colors: #{@available_colors.join(', ')}"
    input = gets.chomp.downcase
    if @available_colors.include?(input)
      @maker_colors.push(input)
      set_maker_colors(remaining - 1, current + 1)
    else
      puts 'Sorry, this color is not available. Please try again.'
      set_maker_colors(remaining, current)
    end
  end

  def breaker_play
    puts 'Breaker\'s time to shine.'
    puts @code_breaker.play(@available_colors)
  end
end

cpu = Computer.new
player = Player.new('John Smith')

game = Game.new(player, cpu)

game.start_game

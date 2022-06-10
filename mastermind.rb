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

  def get_breaker_colors(color_list, color_amount)
    guess_list = []
    guess_sum = 0
    while guess_sum < color_amount
      puts "Breaker, please pick color ##{guess_sum + 1}. Available colors: #{color_list.join(', ')}"
      input = gets.chomp.downcase
      if color_list.include?(input)
        guess_list.push(input)
        guess_sum += 1
      else
        puts 'Sorry, this color is not available. Please try again.'
      end
    end
    guess_list
  end

  def set_maker_colors(available, amount = 4)
    color_list = []
    input_sum = 0
    while input_sum < amount
      puts "Breaker, please pick color ##{input_sum + 1}. Available colors: #{available.join(', ')}"
      input = gets.chomp.downcase
      if available.include?(input)
        color_list.push(input)
        input_sum += 1
      else
        puts 'Sorry, this color is not available. Please try again.'
      end
    end
    color_list
  end

end

class Computer < Player
  def initialize
    name = ['Saul Bitman', 'Ternary Tristan', 'Octal John', 'Marcus Loopius'].sample
    super(name)
  end

  def random_color(color_list)
    color_list.sample
  end

  def play(color_list)
    random_color(color_list)
  end
  def random_list(available, amount)
    list = []
    amount.times { list.push(random_color(available))}
    list
  end
  def get_breaker_colors(available, color_amount)
    random_list(available, color_amount)
  end

  def set_maker_colors(available, color_amount)
    random_list(available, color_amount)
  end

end

class Game
  def initialize(code_maker, code_breaker, max_guesses = 10, color_amount = 4)
    @code_maker = code_maker
    @code_breaker = code_breaker
    @maker_colors = []
    @max_guesses = max_guesses
    @color_amount = color_amount
    @available_colors = %w[red green yellow orange blue purple]
  end

  def start_game
    @maker_colors = @code_maker.set_maker_colors(@available_colors, @color_amount)
    breaker_play
  end

  private

  def breaker_play
    puts 'Breaker\'s time to shine.'
    guessed_colors = @code_breaker.get_breaker_colors(@available_colors, @color_amount)
    response = guess_response(guessed_colors)
    p guessed_colors
    p response
  end



  def guess_response(guess_list)
    color_frequency = get_frequency(@maker_colors)
    response_list = []
    guess_list.each_with_index do |color, index|
      if color == @maker_colors[index]
        response_list << 'O'
        color_frequency[color] -= 1
      elsif !color_frequency[color].zero? && @maker_colors.include?(color)
        response_list << '?'
        color_frequency[color] -= 1
      else
        response_list << 'X'
      end
    end
    response_list
  end

  def get_frequency(guess_list)
    frequency = Hash.new(0)
    guess_list.each { |guess| frequency[guess] += 1 }
    frequency
  end
end

cpu = Computer.new
player = Player.new('John Smith')

game = Game.new(player, cpu)

game.start_game

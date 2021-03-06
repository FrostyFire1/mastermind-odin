class Player
  attr_reader(:name)
  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
  end

  def get_breaker_colors(color_list, color_amount)
    guess_list = []
    guess_sum = 0
    while guess_sum < color_amount
      puts "#{@name}, please guess color ##{guess_sum + 1}. Available colors: #{color_list.join(', ')}"
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
      puts "#{@name}, please pick color ##{input_sum + 1} to encode. Available colors: #{available.join(', ')}"
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
    @current_guess = 0
    @color_amount = color_amount
    @available_colors = %w[red green yellow orange blue purple]
  end

  def start_game
    puts "#{@code_maker.name} - Maker"
    puts "#{@code_breaker.name} - Breaker"
    @maker_colors = @code_maker.set_maker_colors(@available_colors, @color_amount)
    breaker_play
  end

  private

  def breaker_play
    puts "Guess ##{@current_guess+1}"
    guessed_colors = @code_breaker.get_breaker_colors(@available_colors, @color_amount)
    response_list = guess_response(guessed_colors)
    @current_guess += 1
    if response_list.all? { |response| response == 'X' }
      win
      p @maker_colors
      p guessed_colors
    elsif @current_guess >= @max_guesses
      lose
      p @maker_colors
      p guessed_colors
    else
      breaker_play
    end
  end

  def win
    puts "#{@code_breaker.name} won!"
  end

  def lose
    puts "#{@code_breaker.name} lost!"
  end

  def guess_response(guess_list)
    color_frequency = get_frequency(@maker_colors)
    response_list = []
    guess_list.each_with_index do |color, index|
      if color == @maker_colors[index]
        response_list << 'X'
        color_frequency[color] -= 1
      elsif !color_frequency[color].zero? && @maker_colors.include?(color)
        response_list << '?'
        color_frequency[color] -= 1
      else
        response_list << '-'
      end
    end
    response_list.shuffle!
    puts "#{@code_breaker.name} gussed: #{response_list.join(', ')}"
    response_list
  end

  def get_frequency(guess_list)
    frequency = Hash.new(0)
    guess_list.each { |guess| frequency[guess] += 1 }
    frequency
  end
end

cpu = Computer.new
puts "What's your name?"
player_name = gets.chomp
player = Player.new(player_name)
puts 'Welcome to mastermind! Symbol translation:'
puts 'X - correct color and place'
puts '? - correct color, incorrect place'
puts '- - incorrect color'
input = ''
while input.empty?
  puts 'Would you like to be the code maker or code breaker?'
  puts '1 - Maker'
  puts '2 - Breaker'
  response = gets.chomp
  if %w[1 2].include?(response)
    input = response 
  else
    puts 'Invalid input. Please try again.'
  end
end
maker, breaker = if input == '1'
                  [player, cpu]
                else
                  [cpu, player]
                end
game = Game.new(maker, breaker)

game.start_game

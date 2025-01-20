require 'json'
require_relative 'Player'
require_relative 'Board'
require_relative 'Property'

class Monopoly
  attr_accessor :players, :board, :dice_rolls

  def initialize(board_file,roll_dice_file)

    @dice_rolls = load_dice_rolls("rolls_1.json")
    
    @board = Board.new("board.json")

    @players = [
      Player.new("Peter"),
      Player.new("Billy"),
      Player.new("Charlotte"),
      Player.new("Sweedal")
    ]

  end


  def load_dice_rolls(file)
    rolls = JSON.parse(File.read(file))
    puts rolls  # Print the dice rolls
    rolls       # Return the parsed rolls
  end

  def game_start
    #

    return print_winner if current_player.is_bankrupt?

  end

  def take_turn_to_move(player,roll)
    board_size = @board.locations.size
    player.move(roll, board_size)

    current_property = @board.get_property(player.position)

    if current_property.type == "property"
      if current_property.owned?
        pay_rent(player, current_property)
      else
        player.buy_property(current_property)
      end
    end
    #
  end

  def rent_settlement(player,property)
    #
    rent_fee = calculate_rent_price(property)
    player.pay_rent(rent_fee)
    property.owner.money += rent_fee
  end


  def calculate_rent_price(property)
    #
    rent = property.price
    if check_full_colour_set(property.owner, property.colour)
      rent *= 2
    end
    rent
  end

  def check_full_colour_set(owner, colour)
    owner.properties.select { |prop| prop.colour == colour }.size ==
      @board.locations.count { |prop| prop.colour == colour }
  end

  def print_winner
    winner = @players.reject(&:is_bankrupt?).max_by(&:money)
    puts "Game Over! The winner is #{winner.name} with $#{winner.money}."
    @players.each do |player|
      puts "#{player.name} has $#{player.money} and is on space #{@board.locations[player.position].name}."
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  board_file = 'board.json'  # Path to the board file
  dice_rolls_file = 'rolls_1.json'  # Path to the dice rolls file

  game = Monopoly.new(board_file, dice_rolls_file)
  game.game_start
end
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
    return rolls
  end

  def game_start

    current_player_index = 0

    @dice_rolls.each do |roll|
      current_player = @players[current_player_index]

      take_turn_to_move(current_player, roll)

      # end of the game if the first player bankrupt, and print out info
      return print_game_result if current_player.is_bankrupt?

      # next player to move
      current_player_index = (current_player_index + 1) % @players.size
    end

    # if no winner still print result
    print_game_result
  end

  def take_turn_to_move(player,roll)
    board_size = @board.locations.size

    player.move(roll, board_size)

    current_property = @board.get_property(player.position)

    if current_property.type == "property"
      if current_property.owned?
        # pay rent fee
        rent_settlement(player, current_property)
      else
        player.buy_property(current_property)
      end
    end
    #
  end


  def rent_settlement(player,property)

    rent_fee = calculate_rent_price(property)

    player.pay_rent(rent_fee)

    property.owner.money += rent_fee
  end


  def calculate_rent_price(property)
    #assume rent is property price
    rent = property.price

    #get all same colour property from a player and compare it, 
    if property.owner.properties.select  { |prop| prop.colour == property.colour }.size == 
    @board.locations.count { |prop| prop.colour == property.colour } # total count from a colour
      rent *= 2
    end

    return rent
  end

  def print_game_result
    winner = @players.reject{ |player| player.is_bankrupt? }.max_by{ |player| player.money }
    puts "Game Over! The winner is #{winner.name} with $#{winner.money}."
    @players.each do |player|
      puts "#{player.name} has $#{player.money} and is on space #{@board.locations[player.position].name}."
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  board_file = 'board.json'
  dice_rolls_file = 'rolls_1.json'

  game = Monopoly.new(board_file, dice_rolls_file)
  game.game_start
end
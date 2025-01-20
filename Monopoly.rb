require 'json'
require_relative 'Player'
require_relative 'Board'
require_relative 'Property'

class Monopoly
  attr_accessor :players, :board, :dice_rolls

  def initialize(board_file,roll_dice_file)
    @players = [
      Player.new("Peter"),
      Player.new("Billy"),
      Player.new("Charlotte"),
      Player.new("Sweedal")
    ]

    @board = Board.new("board.json")

    @dice_rolls = load_dice_rolls("rolls_1.json")

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

    #
  end

  def pay_rent(player,property)
    #
  end


  def calculate_rent_price(property)
    #
  end

  def check_full_colour_set(owner,color)
    #
  end

  def print_winner()
    puts "Gave Over the winner is #{player.name}"

  end

end

if __FILE__ == $PROGRAM_NAME
  board_file = 'board.json'  # Path to the board file
  dice_rolls_file = 'rolls_1.json'  # Path to the dice rolls file

  game = Monopoly.new(board_file, dice_rolls_file)
  game.game_start
end
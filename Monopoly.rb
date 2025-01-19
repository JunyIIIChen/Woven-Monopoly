require 'json'

class Monopoly
  attr_accessor :players, :board, :rolls

  def initialize(board_file,roll_dice_file)
    @players = [
      Player.new("Peter"),
      Player.new("Billy"),
      Player.new("Charlotte"),
      Player.new("Sweedal")
    ]

    @board = Board.load_board("board.json")

  end


  def game_start
    #
  end

  def take_turn
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

  def check_winner
    # puts "Gave Over the winner is #{player.name}"
  end

end
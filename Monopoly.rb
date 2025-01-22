require 'json'
require_relative 'Player'
require_relative 'Board'
require_relative 'Property'

# The Monopoly class encapsulates the main game logic for a simplified Monopoly game.
class Monopoly
  attr_accessor :players, :board, :dice_rolls

  # Initialize the Monopoly game with the board and dice roll data.
  # @param board_file [String] The file containing board information (JSON).
  # @param roll_dice_file [String] The file containing dice roll data (JSON).
  def initialize(board_file, roll_dice_file)
    # Load dice rolls from the specified file.
    @dice_rolls = load_dice_rolls("rolls_1.json")
    
    # Load the board from the specified file.
    @board = Board.new("board.json")

    # Initialize the players for the game.
    @players = [
      Player.new("Peter"),
      Player.new("Billy"),
      Player.new("Charlotte"),
      Player.new("Sweedal")
    ]
  end

  # Load dice roll data from a JSON file.
  # @param file [String] Path to the JSON file containing dice rolls.
  # @return [Array<Integer>] Array of dice roll values.
  def load_dice_rolls(file)
    rolls = JSON.parse(File.read(file))
    return rolls
  end

  # Start the game and process each player's turn using the provided dice rolls.
  def game_start
    current_player_index = 0

    @dice_rolls.each do |roll|
      # Identify the current player.
      current_player = @players[current_player_index]

      # Execute the player's turn with the current dice roll.
      take_turn_to_move(current_player, roll)

      # Check if the player has gone bankrupt; end the game if true.
      return print_game_result if current_player.is_bankrupt?

      # Move to the next player in a round-robin manner.
      current_player_index = (current_player_index + 1) % @players.size
    end

    # Print game results if all dice rolls have been processed.
    print_game_result
  end

  # Process a single turn for the given player based on the dice roll.
  # @param player [Player] The player taking their turn.
  # @param roll [Integer] The dice roll for the turn.
  def take_turn_to_move(player, roll)
    # Calculate the board size for wrapping around.
    board_size = @board.locations.size

    # Move the player based on the dice roll.
    player.move(roll, board_size)

    # Get the property at the player's current position.
    current_property = @board.get_property(player.position)

    # Handle property interactions based on type and ownership.
    if current_property.type == "property"
      if current_property.owned?
        # Player pays rent if the property is owned by another player.
        rent_settlement(player, current_property)
      else
        # Player has the opportunity to buy the unowned property.
        player.buy_property(current_property)
      end
    end
  end

  # Handle rent settlement when a player lands on an owned property.
  # @param player [Player] The player paying rent.
  # @param property [Property] The property requiring rent payment.
  def rent_settlement(player, property)
    # Calculate the rent fee for the property.
    rent_fee = calculate_rent_price(property)

    # Deduct the rent fee from the player and add it to the owner's balance.
    player.pay_rent(rent_fee)
    property.owner.money += rent_fee
  end

  # Calculate the rent price for a given property.
  # Rent doubles if the owner holds all properties of the same color.
  # @param property [Property] The property being evaluated.
  # @return [Integer] The calculated rent amount.
  def calculate_rent_price(property)
    rent = property.price

    # Check if the owner has a monopoly on properties of the same color.
    if property.owner.properties.select { |prop| prop.colour == property.colour }.size == 
       @board.locations.count { |prop| prop.colour == property.colour }
      rent *= 2
    end

    return rent
  end

  # Print the final game result, including the winner and player details.
  def print_game_result
    # Determine the winner (non-bankrupt player with the most money).
    winner = @players.select { |player| !player.is_bankrupt? }.max_by { |player| player.money }
    puts "Game Over! The winner is #{winner.name} with $#{winner.money}."

    # Print the status of all players at the end of the game.
    @players.each do |player|
      puts "#{player.name} has $#{player.money} and is on space #{@board.locations[player.position].name}."
    end
  end
end

# Run the game if the script is executed directly.
if __FILE__ == $PROGRAM_NAME
  board_file = 'board.json'
  dice_rolls_file = 'rolls_1.json'

  game = Monopoly.new(board_file, dice_rolls_file)
  game.game_start
end

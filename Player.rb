# The Player class represents a player in the Monopoly game.
class Player

  attr_accessor :name, :money, :position, :properties

  # Initialize a new Player object with a given name.
  def initialize(name)
    @name = name     
    @money = 16    
    @position = 0  
    @properties = []
  end

  # Move the player by a certain number of steps on the board.
  # @param steps [Integer] The number of spaces to move on the board.
  # @param board_size [Integer] The size of the board (total number of spaces).
  def move(steps, board_size)
    previous_position = @position  # Keep track of the previous position.

    # Update the player's position.
    @position = (@position + steps) % board_size

    # If the player passed "GO", they receive $1.
    @money += 1 if @position < previous_position
  end

  # Allow the player to buy a property if they have enough money.
  # @param property [Property] The property that the player wants to purchase.
  def buy_property(property)
    # The player can only buy the property if they have enough money.
    return unless @money >= property.price
    
    @money -= property.price

    @properties << property

    property.owner = self
  end

  # Deduct the specified rent amount from the player's money when they land on an owned property.
  # @param amount [Integer] The rent amount to be paid.
  def pay_rent(amount)
    @money -= amount
  end

  # Check if the player is bankrupt (i.e., they have no money).
  # @return [Boolean] True if the player's money is less than or equal to 0, false otherwise.
  def is_bankrupt?
    @money < 0
  end
end

# The Property class represents a single property on the Monopoly board.
class Property
  # Accessor methods to read and write property attributes.
  attr_accessor :name, :colour, :price, :owner, :type

  def initialize(name, colour=nil, price=nil, type=nil)
    @name = name      
    @colour = colour  
    @price = price    
    @type = type      
    @owner = nil      
  end

  # Check if the property is owned by a player.
  # @return [Boolean] True if the property has an owner, false otherwise.
  def owned?
    !@owner.nil?  # If the owner is not nil, the property is owned.
  end
end
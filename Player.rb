class Player
  
  attr_accessor :name, :money, :position, :properties

  def initialize(name)
    @name = name
    @money = 16
    @position = 0
    @properties = []
  end

  def move(steps, board_size)
    previous_position = @position

    @position = (@position + steps) % board_size

    @money += 1 if @position < previous_position # Pass GO
  end

  def buy_property(property)
    return unless @money >= property.price
    @money -= property.price
    @properties << property
    property.owner = self
  end

  def pay_rent(amount)
    @money -= amount
  end

  
  def is_bankrupt?
    @money <= 0
  end
end

class Property
  attr_accessor :name, :colour, :price, :owner, :type

  def initialize(name, colour, price,type)
    @name = name
    @colour = colour
    @price = price
    @type = type
    @owner = nil
  end

  def owned?
    !@owner.nil?
  end

  def calculate_rental_fee
    # Double price if owner owns all properties of the same colour
    if @owner && @owner.properties.count { |p| p.colour == @colour } > 1
      @price * 2
    else
      @price
    end
  end
end
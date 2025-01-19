class Property
  attr_accessor :name, :colour, :price, :rental_fee, :owner

  def initialize(name, colour, price, rental_fee)
    @name = name
    @colour = colour
    @price = price
    @rental_fee = rental_fee
    @owner = nil
  end

  def owned?
    !@owner.nil?
  end

  def calculate_rental_fee
    # Double rental_fee if owner owns all properties of the same colour
    if @owner && @owner.properties.count { |p| p.colour == @colour } > 1
      @rental_fee * 2
    else
      @rental_fee
    end
  end
end
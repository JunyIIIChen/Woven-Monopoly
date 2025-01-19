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

end
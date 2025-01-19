class Property
  attr_accessor :name, :colour, :price, :owner, :type

  def initialize(name, colour=nil, price=nil,type=nil)
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
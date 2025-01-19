require 'json'

class Board
  attr_accessor :locations

  def initialize(board_file)
    @locations = load_board(board_file)
  end

  def load_board(file)
    JSON.parse(File.read(file)).map do |property|
      Property.new(property['name'], 
      property['color'], 
      property['price'], 
      property['rent'])
    end
  end

  def get_property(position)
    @locations[position]
  end
end
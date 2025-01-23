require 'json'

# The Board class represents the game board in the Monopoly game.
class Board
  attr_accessor :locations

  # Initialize the Board object by loading the board configuration from a JSON file.
  # @param board_file [String] The path to the JSON file containing the board's configuration.
  def initialize(board_file)
    # Load the properties from the provided board file and store them in @locations.
    @locations = load_board(board_file)
  end

  # Load the board configuration from a JSON file and convert it to an array of Property objects.
  # @param file [String] The path to the JSON file containing board data.
  # @return [Array<Property>] An array of Property objects.
  def load_board(file)
    # Read the JSON file and parse it into a Ruby hash, then map it to Property objects.
    JSON.parse(File.read(file)).map do |property|
      Property.new(
        property['name'],   
        property['colour'], 
        property['price'], 
        property['type']
      )
    end
  end

  # Get the property located at a specific position on the board.
  # @param position [Integer] The index of the property on the board.
  # @return [Property] The Property object at the specified position.
  def get_property(position)
    @locations[position]
  end
end

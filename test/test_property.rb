require 'minitest/autorun'
require_relative '../Property.rb'
require_relative '../Player'

class TestPlayer < Minitest::Test
  def setup
    @property = Property.new("The Burvale", "Brown", 1,"property")
    # @owner = Player.new('Patrick Chen')
  end

  def test_initial_attributes
    assert_equal "The Burvale", @property.name
    assert_equal 1, @property.price
    assert_equal "Brown", @property.colour
    assert_equal 'property', @property.type
    assert_equal nil, @property.owner
  end
end
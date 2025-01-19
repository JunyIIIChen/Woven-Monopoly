require 'minitest/autorun'
require_relative '../Board'
require_relative '../Property'

class TestBoard < Minitest::Test
  def setup
    @board_file = "../board.json"

    @board = Board.new("board.json")
  end

  def test_initial_board
    #test board start data
    assert_equal "GO", @board.locations[0].name
    assert_equal "go", @board.locations[0].type

    #test first property data
    assert_equal "The Burvale", @board.locations[1].name
    assert_equal "Brown", @board.locations[1].colour
    assert_equal 1, @board.locations[1].price
    assert_equal "property", @board.locations[1].type

    #test the last(8th) property data
    assert_equal "Massizim", @board.locations[8].name
    assert_equal "Blue", @board.locations[8].colour
    assert_equal 4, @board.locations[8].price
    assert_equal "property", @board.locations[8].type

    #edge case test 9th--> back to go
    assert_equal "GO", @board.locations[9].name
    assert_equal "go", @board.locations[9].type

  end
end
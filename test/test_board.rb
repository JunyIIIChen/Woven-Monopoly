require 'minitest/autorun'
require_relative '../Board'
require_relative '../Property'

class TestBoard < Minitest::Test
  def setup
    @board_file = "../board.json"

    @board = Board.new("board.json")
  end

  def test_initial_board
    assert_instance_of Property, @board.locations[0]
    assert_equal "go", @board.locations[0].type

  end
end
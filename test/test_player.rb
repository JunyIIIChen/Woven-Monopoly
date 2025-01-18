require 'minitest/autorun'
require_relative '../Player'

class TestPlayer < Minitest::Test
  def setup
    @player = Player.new('Peter')
  end

  # Basic function test
  def test_initial_attributes
    assert_equal 'Peter', @player.name
    assert_equal 16, @player.money
    assert_equal 0, @player.position
  end

  def test_move
    @player.move(5, 9) # board size 9
    assert_equal 5, @player.position
    assert_equal 16, @player.money # do not pass GO，no money add

    @player.move(6, 9) # pass GO, get $1
    assert_equal 2, @player.position
    assert_equal 17, @player.money
  end

  def test_bankrupt
    @player.money = -1
    assert @player.is_bankrupt?

    @player.money = 10
    refute @player.is_bankrupt?
  end

  # edge case test
end

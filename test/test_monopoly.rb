require 'minitest/autorun'
require 'json'
require_relative '../monopoly'

class TestMonopoly < Minitest::Test
  def setup
    @board_file = 'board.json'
    @dice_rolls_file = 'rolls_1.json'
    @game = Monopoly.new(@board_file, @dice_rolls_file)
  end

  def test_initialize_game
    #test players have been generated
    player_names = @game.players.map{ |player| player.name }

    assert_equal "Peter", player_names[0]
    assert_equal "Billy", player_names[1]
    assert_equal "Charlotte", player_names[2]
    assert_equal "Sweedal", player_names[3]
    assert_equal 4, @game.players.size
  end


  def test_pass_go_get_one_dollar
    player = @game.players[0]
    initial_money = player.money
    player.position = @game.board.locations.size - 1
    
    # assert_equal @game.board.locations.size - 1, player.position
    # assert_equal 16, player.money

    
    assert_equal 8, player.position




    @game.take_turn_to_move(player,2)
    # assert_equal 2, player.position
    
    assert_equal 1, player.position
    
    assert_equal 16, player.money
  end
  
end
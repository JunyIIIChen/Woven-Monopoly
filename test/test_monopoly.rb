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
    #correct load dice rolls
    refute_empty @game.dice_rolls

    #correct load board
    refute_empty @game.board.locations

    #test players have been generated
    player_names = @game.players.map{ |player| player.name }

    assert_equal "Peter", player_names[0]
    assert_equal "Billy", player_names[1]
    assert_equal "Charlotte", player_names[2]
    assert_equal "Sweedal", player_names[3]
    assert_equal 4, @game.players.size
  end

  # test pass go get money, including stop at place go
  def test_pass_go_get_one_dollar
    player = @game.players[0]
    initial_money = player.money

    # set player on the last place, move one step forward to 0, the player get one dollar.
    player.position = @game.board.locations.size - 1
    @game.take_turn_to_move(player,1)
    assert_equal 0, player.position   
    assert_equal 17, player.money
    # assert_equal  "The Burvale", player.properties[0].name
  end

  def test_calculate_rent_price
    # get two green properties, Betty's Burgers and YOMG
    property = @game.board.get_property(5)
    second_property = @game.board.get_property(6)

    # create owner, give these 2 properties to owner
    owner = Player.new("Owner")
    property.owner = owner
    owner.properties << property    
    second_property.owner = owner
    owner.properties << second_property
    
    # property 1 price is 3
    rent = @game.calculate_rent_price(property)
    
    assert_equal 6, rent
  end
end
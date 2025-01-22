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
    property2 = @game.board.get_property(6)

    # create owner, give these 2 properties to owner
    owner = Player.new("Owner")
    property.owner = owner
    owner.properties << property    
    property2.owner = owner
    owner.properties << property2
    
    # property 1 price is 3
    rent = @game.calculate_rent_price(property)
    
    assert_equal 6, rent
  end

  def test_pay_rent
    player = @game.players[0]
    player2 = @game.players[1]
    property = @game.board.get_property(1)
    # set player2 as the owner of the property
    property.owner = player2

    # simulate player1 landing on player2's property
    @game.take_turn_to_move(player, @game.dice_rolls[0])

    #player pay 1 to player2
    assert_equal 15, player.money
    assert_equal 17, player2.money
  end

  def test_buy_property
    property = @game.board.get_property(1)
    player1 = @game.players[0]

    initial_money_player1 = player1.money

    # to test(first) property
    @game.take_turn_to_move(player1, @game.dice_rolls[0])  
    assert_equal property, @game.board.get_property(player1.position)

    # ensure the property belongs to the buyer
    assert_equal player1, property.owner
  end

  def test_bankrupt_and_winner
    player1 = @game.players[0]
    player2 = @game.players[1]
    player3 = @game.players[2]
    player2.money = 222
    player3.money = 123

    # simulate player1 going bankrupt
    player1.money = 0
    player1.is_bankrupt?

    # assert that the winner is the one with the most money and not bankrupt
    winner = @game.players.select { |player| !player.is_bankrupt? }.max_by { |player| player.money }
    assert_equal 222, winner.money
    assert_equal "Billy", winner.name

  end

end
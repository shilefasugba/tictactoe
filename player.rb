class Player
  attr_accessor :name, :symbol
  def initialize(name, symbol)
    raise(StandardError, 'Player name & symbol required.') unless name && symbol

    @name = name
    @symbol = symbol
  end

  def self.default_players
    [Player.new('Player 1', 'X'), Player.new('Player 2', 'O')]
  end
end

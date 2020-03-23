class Board
  attr_accessor :grid, :game_state

  SIZE = 9
  WIN_INDICES = [
    [0, 1, 2], [0, 3, 6], [0, 4, 8],
    [1, 4, 7], [2, 5, 8], [2, 4, 6],
    [3, 4, 5], [6, 7, 8]
  ].freeze

  GAME_STATES = %w[active player_won draw].freeze

  def initialize(size = SIZE)
    @grid = Array.new(size)
    @game_state = GAME_STATES[0]
  end

  GAME_STATES.each do |game_state|
    define_method("#{game_state}?") { self.game_state == game_state }
  end

  def to_s
    puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
    puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
    puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
  end

  def length
    @grid.length
  end

  def update_game_state(current_player)
    if player_won_game?(current_player.symbol)
      player_won!
      puts "Player: #{current_player.name} has won the game!"
    elsif all_positions_occupied?
      draw!
      puts "All positions have been occupied. The game is a draw!"
    end
  end

  def player_won!
    self.game_state = GAME_STATES[1]
  end

  def draw!
    self.game_state = GAME_STATES[2]
  end

  def all_positions_occupied?
    (0..SIZE - 1).each do |num|
      return false if unoccupied_position?(num)
    end

    true
  end

  def player_won_game?(player_symbol)
    WIN_INDICES.each do |arr|
      if @grid[arr[0]] == player_symbol && @grid[arr[1]] == player_symbol && @grid[arr[2]] == player_symbol
        return true
      end
    end

    false
  end

  def unoccupied_position?(pos)
    @grid[pos].nil?
  end

  def pos_within_grid?(pos)
    pos >= 0 && pos < length
  end

  def valid_position(pos)
    pos_within_grid?(pos) && unoccupied_position?(pos)
  end

  def output_board
    puts "Board"
    puts "==========================="
    puts to_s
    puts "==========================="
  end

  def set_player_position(index, symbol)
    @grid[index] = symbol
  end
end

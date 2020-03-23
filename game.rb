require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :players, :board, :game_over, :current_turn_player

  def initialize
    @board = Board.new
    @players = Player.default_players
    @current_turn_player = @players.first
    @game_over = false
  end

  def loop_turn
    puts "It is #{@current_turn_player.name}'s turn. [#{@current_turn_player.symbol}]"

    pos = new_position

    @board.set_player_position(pos, @current_turn_player.symbol)

    puts "#{@current_turn_player.name} [#{@current_turn_player.symbol}] has played in position: #{pos}."

    @board.output_board

    before_turn_end
  end

  def new_position
    pos = nil

    loop do
      puts "#{@current_turn_player.name}, please enter a board index to play."
      pos = gets.to_i

      break if @board.valid_position(pos)

      puts "Invalid postion. Please make sure the given index is within range 0 - #{@board.length - 1} and has not been occupied."
    end

    pos
  end

  def before_turn_end
    @board.update_game_state(@current_turn_player)

    if @board.active?
      switch_player
    else
      @game_over = true
    end
  end

  def switch_player
    @current_turn_player = @current_turn_player == @players.first ? @players.last : @players.first
  end

  def self.play
    puts "Welcome to Tic Tac Toe"
    game = Game.new
    game.board.output_board
    game.loop_turn until game.game_over
  end
end

Game.play

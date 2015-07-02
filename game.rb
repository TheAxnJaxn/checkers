require 'io/console'
require_relative 'board.rb'

class Game

  def initialize
    @players = [:white, :blue]
    @board = Board.new
  end

  def run
    until @board.game_over?
      render_board
      piece_pos = select_piece
      end_pos = select_end_pos
      @board.make_move(piece_pos, end_pos)
      rotate_player
    end
  end

  def render_board
    @board.render
  end

  def select_piece
    puts "Select one of your pieces to move, #{current_player}"
    cursor_movement
  end

  def select_end_pos
    puts "Select where you'd like to move your piece."
    cursor_movement
  end

  def current_player
    @players.first
  end

  def rotate_player
    @players.reverse!
  end

  def cursor_movement
    while true
      key_press = STDIN.getch
      # check if it was \r (enter)
      increment = key_press_coordinate(key_press)
      @board.move_cursor(increment)
      render_board
      break if key_press == "\u0003"
      # return the cursor position if \r
      return @board.cursor_pos if key_press == "\r"
    end
  end

  CURSOR_MOVEMENT = [[-1,0], [0,1], [1, 0], [0,-1], [0,0]]

  def key_press_coordinate(string)
    case string
    when "w"
      return CURSOR_MOVEMENT[0]
    when "d"
      return CURSOR_MOVEMENT[1]
    when "s"
      return CURSOR_MOVEMENT[2]
    when "a"
      return CURSOR_MOVEMENT[3]
    when "\r"
      return CURSOR_MOVEMENT[4]
    end
  end

end

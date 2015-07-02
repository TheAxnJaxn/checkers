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
    input = gets.chomp
  end

  def select_end_pos
    puts "Select where you'd like to move your piece."
    input = gets.chomp
  end

  def current_player
    @players.first
  end

  def rotate_player
    @players.reverse!
  end
end

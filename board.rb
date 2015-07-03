require 'byebug'
require_relative 'piece.rb'
require 'colorize'

class Board

  attr_reader :cursor_pos

  def initialize(board_size = 8)
    @grid = Array.new(board_size) {Array.new(board_size)}
    populate(board_size)
    @cursor_pos = [0,0]
  end

  def make_move(piece_pos, end_pos)
    piece_row, piece_col = piece_pos # parse array
    end_row, end_col = end_pos # parse array
    selected_piece = @grid[piece_row][piece_col] #object at that location

    if selected_piece.move_diffs.include?(end_pos) && is_jump?(piece_pos, end_pos)
      kill_piece(piece_pos, end_pos)
      update_board(piece_pos, end_pos)
      selected_piece.perform_move(end_pos)
    elsif selected_piece.move_diffs.include?(end_pos)
      update_board(piece_pos, end_pos)
      selected_piece.perform_move(end_pos)
    else
      puts "Sorry, but that piece cannot make that move"
      return false
    end
    true
  end

  def is_jump?(start_pos, end_pos)
    start_row, start_col = start_pos # parse array
    end_row, end_col = end_pos # parse array
    return true if (start_row - end_row).abs == 2
  end

  def is_enemy?(piece_pos, check_pos)
    piece_row, piece_col = piece_pos # parse array
    check_row, check_col = check_pos # parse array
    selected_piece = @grid[piece_row][piece_col] #object at that location
    checking_piece = @grid[check_row][check_col]
    selected_piece.color != checking_piece.color ? true : false
  end

  def kill_piece(piece_pos, end_pos)
    piece_row, piece_col = piece_pos # parse array
    end_row, end_col = end_pos # parse array

    if piece_row - end_row == -2
      killed_row_idx = piece_row + 1
    elsif piece_row - end_row == 2
      killed_row_idx = piece_row - 1
    end
    if piece_col - end_col == -2
      killed_col_idx = piece_col + 1
    elsif piece_col - end_col == 2
      killed_col_idx = piece_col - 1
    end

    @grid[killed_row_idx][killed_col_idx] = NullObject.new([piece_row, piece_col], :yellow)
  end

  def update_board(piece_pos, end_pos)
    piece_row, piece_col = piece_pos # parse array
    end_row, end_col = end_pos # parse array

    @grid[end_row][end_col] = @grid[piece_row][piece_col]
    @grid[piece_row][piece_col] = NullObject.new([piece_row, piece_col], :yellow)
  end

  def game_over?
    false
  end

  def populate(board_size)
    # populates the board of an appropriate size with pieces
    @grid.each_with_index do |row, row_idx|
      row_idx < 3 ? color = :white : color = :blue
      row.each_with_index do |square, col_idx|

      if row_idx < 3 || row_idx > board_size - 4
      # if statement to check that it's the first or last 3 rows of any board size
        if (row_idx.even? && col_idx.even?) || (row_idx.odd? && col_idx.odd?)
          #fills with alternating pieces and null objects
          @grid[row_idx][col_idx] = Piece.new([row_idx, col_idx], color)
        else
          @grid[row_idx][col_idx] = NullObject.new([row_idx, col_idx], color)
        end
      else
      # if it's not the first or last 3 rows, fill with NullObjects
        @grid[row_idx][col_idx] = NullObject.new([row_idx, col_idx], color)
      end

      end
    end
  end

  def render
    system("clear")
    puts

    @grid.each_with_index do |row_array, row_idx|
      row_array.each_with_index do |object, col_idx|

        # if (row_idx.even? && col_idx.even?) || (row_idx.odd? && col_idx.odd?)
        if [row_idx, col_idx] == @cursor_pos
          background_color = :green
        elsif  (row_idx + col_idx).even?
          background_color = :red
        else
          background_color = :black
        end

        print " #{object.visual} ".colorize(:color => object.color, :background => background_color)
      end
      puts
    end
  end

  def move_cursor(increment)
    r,c = increment
    @cursor_pos = [(@cursor_pos[0] + r), (@cursor_pos[1] + c)]
  end
end

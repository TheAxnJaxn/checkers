require_relative 'piece.rb'

class Board

  def initialize(board_size = 8)
    @grid = Array.new(board_size) {Array.new(board_size)}
    populate(board_size)
  end

  def populate(board_size)
    # populates the board of an appropriate size with pieces
    (0...board_size).each do |row_idx|
      row_idx < 2 ? color = :white : color = :red
      (0...board_size).each do |col_idx|

      if row_idx < 3 || row_idx > board_size - 4
      # if statement to check that it's the first or last 3 rows
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

  end
end

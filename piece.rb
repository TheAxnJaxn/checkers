class Piece

  attr_reader :color, :king, :visual

  def initialize(position, color)
    @king = false
    @color = color
    @current_position = position
    @visual = "0"
  end

  def is_king?
    @king
  end

  def make_move?(end_pos)
    # can the piece move to that end_pos?
    true
  end

  def make_move!(end_pos)
    # move piece to that end_pos
    if can_slide?(end_pos)
      perform_slide!(end_pos)
    elsif can_jump?(end_pos)
      perform_jump!(end_pos)
    else
      puts "Sorry, that piece cannot move there"
    end
  end

  def perform_slide(end_pos)
    # update board
    @current_position = end_pos
    maybe_promote
  end

  def can_slide?(end_pos)
    move_diffs.include?(end_pos)
  end

  def can_jump?(end_pos)
    move_diffs.include?(end_pos)
  end

  def perform_jump
    if can_jump?(end_pos)
      # update board
      @current_position = end_pos
      maybe_promote
  end

  def move_diffs
    # returns the directions a piece could move in
    possible_directions = []
    r, c = @current_position

    if @king == true
      possible_directions << [r + 1, c - 1] << [r + 1,  c + 1] << [r + 2, c - 2] << [r + 2, c + 2] << [r - 1, c - c + 1] << [r - 1, c + 1] << [r - 2, c - 2] << [r - 2, c + 2]
    elsif @color == :white
      possible_directions << [r + 1, c - 1] << [r + 1,  c + 1] << [r + 2, c - 2] << [r + 2, c + 2]
    elsif @color == :blue
      possible_directions << [r - 1, c - c + 1] << [r - 1, c + 1] << [r - 2, c - 2] << [r - 2, c + 2]
    end

    # let board narrow these down if they're off the board?
    possible_directions
  end

  def maybe_promote
  # Note to self: Change the white pieces's check of row_idx,
  # to account for a board of any size.
    row_idx = @current_position[0]
    @king = true if @color == :white && row_idx == 7
    @king = true if @color == :blue && row_idx == 0
  end

end

########################################################################

class NullObject

  attr_reader :color, :king, :visual

  def initialize(position, color)
    @king = false
    @color = :yellow
    @current_position = position
    @visual = " "
  end

  def is_king?
    @king
  end
end

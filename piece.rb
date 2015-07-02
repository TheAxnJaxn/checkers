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

  def perform_slide(end_pos)
    # perform a single move
    # illegal slide should return false; else true
    if can_slide?(end_pos)
      update_board(@current_position, end_pos)
      @current_position = end_pos
      maybe_promote
    else
      puts "Sorry, that piece cannot slide there"
    end
  end

  def update_board(current_pos, end_pos)
  end

  def can_slide?(end_pos)
    move_diffs.include?(end_pos)
  end

  def can_jump?(end_pos)
    move_diffs.include?(end_pos)
  end

  def perform_jump
    # perform a single move, if it is allowed to
    # otherwise, it'll raise an error

    # remove jumped piece from the Board
    if can_jump?(end_pos)
      update_board(@current_position, end_pos)
      @current_position = end_pos
      maybe_promote
    else
      puts "Sorry, that piece cannot jump there"
    end
  end

  def move_diffs
    # returns the directions a piece could move in
    possible_directions = []
    r, c = @current_position

    # if it's white(starts at top of board), and not a king,
    # then it could only slide or jump down. a slide or
    # jump coordinate should only be included based on enemy piece nearby.

    # if it's white, and a king, then it can slide/jump up or down.
    # a slide or jump coordinate should only be included based on enemy piece nearby.
    if @color == :white && @king == false
      
      check_for_enemy = [r + 1, c - 1]
    elsif @color == :white && @king == true
    elsif @color == :blue && @king == false
    elsif @color == :blue && @king == true
    end
  end

  SLIDE_DOWN_DELTAS = [[1,-1], [1, 1]]
  JUMP_DOWN_DELTAS = [[2,-2], [2,2]]

  SLIDE_UP_DELTAS = [[-1, -1], [-1, 1]]
  JUMP_UP_DELTAS = [[-2,-2], [-2, 2]]

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

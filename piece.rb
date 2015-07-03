class Piece

  attr_reader :color, :king, :visual, :current_position

  def initialize(position, color)
    @king = false
    @color = color
    @current_position = position
    @visual = "●"
  end

  def is_king?
    @king
  end

  def make_move?(end_pos)
    # can the piece move to that end_pos?
    can_slide?(end_pos) || can_jump?(end_pos)
  end

  def make_move!(end_pos)
    # move piece to that end_pos
    if can_slide?(end_pos)
      perform_slide(end_pos)
    elsif can_jump?(end_pos)
      perform_jump(end_pos)
    else
      puts "Sorry, that piece cannot move there"
    end
  end

  def can_slide?(end_pos)
    moves = move_diffs
    # moves.select { |pos| ((current_position[0] - pos[0]).abs == 1) && ((current_position[1] - pos[1]).abs == 1) }
    moves.include?(end_pos)
  end

  def can_jump?(end_pos)
    moves = move_diffs
    # moves.select {|pos| ((current_position[0] - pos[0]).abs == 2) && ((current_position[1] - pos[1]).abs == 2)}
    moves.include?(end_pos)
  end

  def perform_move(end_pos)
    @current_position = end_pos
    maybe_promote
  end

  def move_diffs
    # returns the directions a piece could move in
    possible_directions = []
    r, c = @current_position

    if @king == true
      possible_directions << [r + 1, c - 1] << [r + 1,  c + 1] << [r + 2, c - 2] << [r + 2, c + 2]
      possible_directions << [r - 1, c - 1] << [r - 1, c + 1] << [r - 2, c - 2] << [r - 2, c + 2]
    elsif @color == :white
      possible_directions << [r + 1, c - 1] << [r + 1,  c + 1] << [r + 2, c - 2] << [r + 2, c + 2]
    elsif @color == :blue
      possible_directions << [r - 1, c - 1] << [r - 1, c + 1] << [r - 2, c - 2] << [r - 2, c + 2]
    end

    possible_directions.select { |pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1]) }
  end

  def is_empty?
    false
  end

  def maybe_promote
    # Note to self: Change the white pieces's check of row_idx,
    # to account for a board of any size.
    row_idx = @current_position[0]
    if @color == :white && row_idx == 7
      @visual = "♛"
      @king = true
    elsif @color == :blue && row_idx == 0
      @visual = "♛"
      @king = true
    end
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

  def is_empty?
    true
  end
end

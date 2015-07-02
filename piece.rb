class Piece

  def initialize(position, color)
    @king = false
    @color = color
    @current_position = position
  end

  def is_king?
    @king
  end

  def perform_slide
  end

  def perform_jump
    # remove jumped piece from the Board
  end

  def move_diffs
  end

  def maybe_promote
  end
end

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

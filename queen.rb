require_relative "piece"

class Queen < Piece
  def show
    color == :black ? " \u265B " : " \u2655 "
  end

  def valid_move?(start, finish)
    a,b = start
    x,y = finish
    super if (x - a).abs == (y - b).abs || x == a || y == b
  end
end

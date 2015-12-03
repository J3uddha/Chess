require_relative "piece"

class Bishop < Piece
  def show
    color == :black ? " \u265D " : " \u2657 "
  end

  def valid_move?(start, finish)
    a,b = start
    x,y = finish
    super if (x - a).abs == (y - b).abs
  end
end

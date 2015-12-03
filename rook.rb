require_relative "piece"

class Rook < Piece
  def show
    color == :black ? " \u265C " : " \u2656 "
  end
  def valid_move?(start, finish)
    a,b = start
    x,y = finish
    super if x == a || y == b
  end
end

require_relative "piece"

class Knight < Piece
  def show
    color == :black ? " \u265E " : " \u2658 "
  end
  def valid_move?(start, finish)
    super
    a,b = start
    x,y = finish
    ((x - a).abs == 1 && (y - b).abs == 2) || ((x - a).abs == 2 && (y - b).abs == 1)
  end
end

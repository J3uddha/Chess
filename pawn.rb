require_relative "piece"

class Pawn < Piece
  def show
    color == :black ? " \u265F " : " \u2659 "
  end

  def valid_move?(start, finish)
    a,b = start
    x,y = finish


    return false if !@board.grid[x][y].nil? && b==y

    # these allow the pawn to move 2 spaces on their first turn
    if color == :white && a == 6 && y==b && (x-a).abs == 2
      return true
    elsif color == :black && a == 1 && y==b && (x-a).abs == 2
      return true
    end

    # these allow the pawns to attack the opp. color diagonally
    if color == :white && a - x == 1 && (b - y).abs == 1 && !board.grid[x][y].nil? && board.grid[x][y].color != color
      return true
    elsif color == :black && a - x == - 1 && (b - y).abs == 1 && !board.grid[x][y].nil? && board.grid[x][y].color != color
      return true
    end

    #this allows pawn to move forward one step & then check it against 'valid_move?'
    super if color == :black ? x-a == +1 && y==b : x-a == -1 && y==b
  end
end

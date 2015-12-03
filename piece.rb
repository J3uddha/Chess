class Piece
  attr_reader :color, :board

  def initialize(color, board)
    @color = color
    @board = board
  end

  def valid_move?(start, finish)

    # deny move if same color is captured
    x,y = finish
    return false if !@board.position(finish).nil? && @color == @board.position(finish).color

    # deny move if start == finish
    if start == finish
      return false
    end

    # skip collision check if it's a knight
    return true if self.is_a?(Knight)

    #check if there's a collision on the selected path
    collision?(start, finish) ? false : true
  end

  private

  def piece_direction(start, finish)
    a, b = start
    x, y = finish

    if    x < a  && y == b #up
      :up
    elsif x > a  && y == b   #down
      :down
    elsif x == a && y < b #left
      :left
    elsif x == a && y > b #right
      :right
    elsif x < a  && y > b #upright -+
      :upright
    elsif x < a  && y < b#upleft --
      :upleft
    elsif x > a  && y > b #downright ++
      :downright
    elsif x > a  && y < b #downleft +-
      :downleft
    end
  end

  def occupied_square? (row, col)
    !@board.grid[row][col].nil?
  end

  def collision?(start, finish)
    a, b = start
    x, y = finish
    path_length = (y-b).abs

    case piece_direction(start, finish)
    when :up
      (x+1...a).each { |i| return true if occupied_square?(i, b) }
    when :down
      (a+1...x).each { |i| return true if occupied_square?(i, b) }
    when :left
      (y+1...b).each { |i| return true if occupied_square?(a, i) }
    when :right
      (b+1...y).each { |i| return true if occupied_square?(a, i) }
    when :upright
      (1...path_length).each { |i| return true if occupied_square?(a-i, b+i) }
    when :downright
      (1...path_length).each { |i| return true if occupied_square?(a+i, b+i) }
    when :downleft
      (1...path_length).each { |i| return true if occupied_square?(a+i, b-i) }
    when :upleft
      (1...path_length).each { |i| return true if occupied_square?(a-i, b-i) }
    else
      raise "error"
    end
    false
  end
end

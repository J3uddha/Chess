require_relative "piece"

class King < Piece

  def show
    color == :black ? " \u265A " : " \u2654 "
  end

  def valid_move?(start, finish)
    a,b = start
    x,y = finish
    super if (x - a).abs < 2 && (y - b).abs < 2
  end

  def find_king
    @board.grid.each.with_index do |row, i|
      row.each.with_index do |tile, j|
        return [i,j] if tile == self
      end
    end
    puts "cannot find king"
    sleep(5)
  end

  def threat?(piece, dir)
    if dir == :up || dir == :down || dir == :left || dir == :right
      piece.is_a?(Queen) || piece.is_a?(Rook)
    elsif dir == :upleft || dir == :downright || dir == :downleft || dir == :upright
      piece.is_a?(Queen) || piece.is_a?(Bishop)
    end
  end

  def danger?(x, y, direction)
    piece = @board.get_piece([x,y])
    if occupied_square?(x, y) && piece.color == color
      false
    else
      threat?(piece, direction)
    end
  end

  def piece_same_color?(x, y)
    piece = @board.get_piece([x, y])
    if !piece.nil?
      @board.get_piece([x, y]).color == self.color
    else
      false
    end
  end

  def in_check?
    a, b = find_king

    if color == :black
      return true if @board.get_piece([a+1,b+1]).is_a?(Pawn) && @board.get_piece([a+1,b+1]).color == :white
      return true if @board.get_piece([a+1,b-1]).is_a?(Pawn) && @board.get_piece([a+1,b-1]).color == :white
    elsif color == :white
      return true if @board.get_piece([a-1,b+1]).is_a?(Pawn) && @board.get_piece([a-1,b+1]).color == :black
      return true if @board.get_piece([a-1,b-1]).is_a?(Pawn) && @board.get_piece([a-1,b-1]).color == :black
    end

    #when :up
    (a-1).downto(0) { |i| danger?(i, b, :up) ? (return true) : (break if piece_same_color?(i, b)) }
    #when :down
    (a+1).upto(7) { |i| danger?(i, b, :down) ? (return true) : (break if piece_same_color?(i, b)) }
    #when :left
    (b-1).downto(0) { |i| danger?(a, i, :left) ? (return true) : (break if piece_same_color?(a, i)) }
    #when :right
    (b+1).upto(7) { |i| danger?(a, i, :right) ? (return true) : (break if piece_same_color?(a, i)) }
    #when :upright
    i=1
    while a - i >=0 && b + i <= 7
      danger?(a-i, b+i, :upright) ? (return true) : (break if piece_same_color?(a-i, b+i))
      i += 1
    end
    #when :downright
    i=1
    while a + i <=7 && b + i <= 7
      danger?(a+i, b+i, :downright) ? (return true) : (break if piece_same_color?(a+i, b+i))
      i += 1
    end
    #when :downleft
    i=1
    while a + i <=7 && b - i >= 0
      danger?(a+i, b-i, :downleft) ? (return true) : (break if piece_same_color?(a+i, b-i))
      i += 1
    end
    #when :upleft
    i=1
    while a - i >= 0 && b - i >= 0
      danger?(a-i, b-i, :upleft) ? (return true) : (break if piece_same_color?(a-i, b-i))
      i += 1
    end

    #check if a knight is putting
    return true if knight_check?(a, b)

    false
  end

  def knight_check?(a, b)

    @board.grid.each_with_index do |row, x|
      row.each_index do |y|
        if ((x - a).abs == 1 && (y - b).abs == 2) || ((x - a).abs == 2 && (y - b).abs == 1)
          return true if @board.get_piece([x,y]).is_a?(Knight)
        end
      end
    end

    false
  end

end

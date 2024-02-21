class Tic_tac_toe
  attr_reader :current_turn
  def initialize
    @current_turn = "X"
    @board = [
      [" _ "," _ "," _ "],
      [" _ "," _ "," _ "],
      [" _ "," _ "," _ "]
    ]
  end

  def display_board
    puts "  0   1   2"
    @board.each_with_index do |row, index|
      puts "#{index} #{row.join("|")}"
    end
  end

  def mark_board(row, column)
    if row.between?(0, 2) && column.between?(0, 2) && @board[row][column] == " _ "
      @board[row][column] = " #{@current_turn} "
      toggle_turn
      true
    else
      puts "Field already used, try another"
      false
    end
  end
  def winner
    winning_positions.each do |position|
      if position.all? { |cell| cell == " X " }
        return "X"
      elsif position.all? { |cell| cell == " O " }
        return "O"
      end
    end
    nil
  end

  private

  def toggle_turn
    @current_turn = (@current_turn == "X") ? "O" : "X"
  end

  def winning_positions
    @board +
    @board.transpose +
    diagonals
  end

  def diagonals
    [
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]]
    ]
  end
end

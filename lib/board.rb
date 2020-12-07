# frozen_string_literal: true

# Board class for creating, checking combos
class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    dummy_board = []
    6.times { dummy_board.push(Array.new(7, '  ')) }
    dummy_board
  end

  def board_full?
    return unless board.all? { |row| row.all? { |item| item != '  ' } }

    puts 'board is full'
    @winner = true
  end

  def check_horizontal_win
    @board.each_index do |index|
      num = 0
      while num < @board[index].length
        current = board[index][num]
        last = board[index][num + 3]
        # frozen_string_literal: true
        return assign_winner(current) if last && check_horizontal_line(current, index, num) && check_current(current)

        num += 1
      end
    end
  end

  def check_horizontal_line(current, index, num)
    @board[index][num + 1] == current &&
      @board[index][num + 2] == current &&
      @board[index][num + 3] == current
  end

  def check_vertical_win
    @board.each_index do |index|
      num = 0
      while num < @board[index].length
        current = board[index][num]
        last = board[index + 3]
        # frozen_string_literal: true
        return assign_winner(current) if last && check_vertical_line(current, index, num) && check_current(current)

        num += 1
      end
    end
  end

  def check_vertical_line(current, index, num)
    @board[index + 1][num] == current &&
      @board[index + 2][num] == current &&
      @board[index + 3][num] == current
  end

  def check_diagonal_right
    @board.each_index do |index|
      num = 0
      while num < @board[index].length
        current = board[index][num]
        last = board[index - 3][num - 3]
        # frozen_string_literal: true
        return assign_winner(current) if last && check_diag_right_line(current, index, num) && check_current(current)

        num += 1
      end
    end
  end

  def check_diag_right_line(current, index, num)
    @board[index - 1][num - 1] == current &&
      @board[index - 2][num - 2] == current &&
      @board[index - 3][num - 3] == current
  end

  def check_diagonal_left
    @board.each_index do |index|
      num = 0
      while num < @board[index].length
        current = board[index][num]
        last = @board[index - 3][num + 3]
        # frozen_string_literal: true
        return assign_winner(current) if last && check_diag_left_line(current, index, num) && check_current(current)

        num += 1
      end
    end
  end

  def check_diag_left_line(current, index, num)
    @board[index - 1][num + 1] == current &&
      @board[index - 2][num + 2] == current &&
      @board[index - 3][num + 3] == current
  end

  def check_current(current)
    !current.nil? && current != '  '
  end

  def assign_winner(current)
    @winner_token = current
    @winner = true
  end

  def showboard
    puts '-----------------------------------------'
    puts "  0     1     2     3     4      5     6 "
    board.each { |row| puts "#{row} \n" }
  end
end

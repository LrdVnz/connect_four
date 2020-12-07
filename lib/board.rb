# frozen_string_literal: true

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
      i = 0
      while i < @board[index].length
        current = board[index][i]
        last = board[index][i + 3] unless board[index][i + 3].nil?
        # frozen_string_literal: true
        if last && check_horizontal_line(current, index, i) && check_current(current)
          @winner_token = current
          @winner = true
        end
        i += 1
      end
    end
  end

  def check_horizontal_line(current, index, i)
    @board[index][i + 1] == current && @board[index][i + 2] == current && @board[index][i + 3] == current
  end

  def check_vertical_win
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        current = board[index][i]
        last = board[index + 3] unless board[index + 3].nil?
        # frozen_string_literal: true
        if last && check_vertical_line(current, index, i) && check_current(current)
          @winner_token = current
          @winner = true
        end
        i += 1
      end
    end
  end

  def check_vertical_line(current, index, i)
    @board[index + 1][i] == current && @board[index + 2][i] == current && @board[index + 3][i] == current
  end

  def check_diagonal_right
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        current = board[index][i]
        last = board[index - 3][i - 3] unless board[index - 3][i - 3].nil?
        # frozen_string_literal: true
        if last && check_diagonal_right_line(current, index, i) && check_current(current)
          @winner_token = current
          @winner = true
        end
        i += 1
      end
    end
  end

  def check_diagonal_right_line(current, index, i)
    @board[index - 1][i - 1] == current && @board[index - 2][i - 2] == current && @board[index - 3][i - 3] == current
  end

  def check_diagonal_left
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        current = board[index][i]
        last = @board[index - 3][i + 3] unless @board[index - 3][i + 3].nil?
        # frozen_string_literal: true
        if last && check_diagonal_left_line(current, index, i) && check_current(current)
          @winner_token = current
          @winner = true
        end
        i += 1
      end
    end
  end

  def check_diagonal_left_line(current, index, i)
    @board[index - 1][i + 1] == current && @board[index - 2][i + 2] == current && @board[index - 3][i + 3] == current
  end

  def check_current(current)
    !current.nil? && current != '  '
  end

  def showboard
    puts '--------------------'
    board.each { |row| puts "#{row} \n" }
  end
end

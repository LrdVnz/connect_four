# frozen_string_literal: true

module BoardCheckers
  def control_horizontal_white(index, i)
    if @board[index][i + 1] != nil && @board[index][i + 2] != nil && @board[index][i + 3] != nil
      @board[index][i + 1] == '⚪' && @board[index][i + 2] == '⚪' && @board[index][i + 3] == '⚪'
    end
  end

  def control_horizontal_black(index, i)
    if @board[index][i + 1] != nil && @board[index][i + 2] != nil && @board[index][i + 3] != nil
      @board[index][i + 1] == '⚫' && @board[index][i + 2] == '⚫' && @board[index][i + 3] == '⚫'
    end
  end

  def control_vertical_white(index, i)
    if @board[index + 1] != nil && @board[index + 2] != nil && @board[index + 3] != nil
      if @board[index + 1][i] != nil && @board[index + 2][i] != nil && @board[index + 3][i] != nil
        @board[index + 1][i] == '⚪' && @board[index + 2][i] == '⚪' && @board[index + 3][i] == '⚪'
      end
    end
  end

  def control_vertical_black(index, i)
    if @board[index + 1] != nil && @board[index + 2] != nil && @board[index + 3] != nil
      if @board[index + 1][i] != nil && @board[index + 2][i] != nil && @board[index + 3][i] != nil
        @board[index + 1][i] == '⚫' && @board[index + 2][i] == '⚫' && @board[index + 3][i] == '⚫'
      end
    end
  end

  def control_diag_right_white(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i - 1] != nil && @board[index - 2][i - 2] != nil && @board[index - 3][i - 3] != nil
        @board[index - 1][i - 1] == '⚪' && @board[index - 2][i - 2] == '⚪' && @board[index - 3][i - 3] == '⚪'
      end
    end
  end

  def control_diag_right_black(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i - 1] != nil && @board[index - 2][i - 2] != nil && @board[index - 3][i - 3] != nil
        @board[index - 1][i - 1] == '⚫' && @board[index - 2][i - 2] == '⚫' && @board[index - 3][i - 3] == '⚫'
      end
    end
  end

  def control_diag_left_white(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i + 1] != nil && @board[index - 2][i + 2] != nil && @board[index - 3][i + 3] != nil
        @board[index - 1][i + 1] == '⚪' && @board[index - 2][i + 2] == '⚪' && @board[index - 3][i + 3] == '⚪'
      end
    end
  end

  def control_diag_left_black(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i + 1] != nil && @board[index - 2][i + 2] != nil && @board[index - 3][i + 3] != nil
        @board[index - 1][i + 1] == '⚫' && @board[index - 2][i + 2] == '⚫' && @board[index - 3][i + 3] == '⚫'
      end
    end
  end
end

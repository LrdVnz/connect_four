# frozen_string_literal: true

require_relative 'board_checkers'

class Board
  include BoardCheckers
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
    if board.all? { |row| row.all? { |item| item != '  ' } }
      puts 'board is full'
      @winner = true
      nil
    end
  end

  def check_horizontal_win
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        if @board[index][i] == '⚪'
          if control_horizontal_white(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          current_sign
          if control_horizontal_black(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def check_vertical_win
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        if @board[index][i] == '⚪'
          if control_vertical_white(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          if control_vertical_black(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def check_diagonal_right
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        if @board[index][i] == '⚪'
          if control_diag_right_white(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          if control_diag_right_black(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def check_diagonal_left
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        if @board[index][i] == '⚪'
          if control_diag_left_white(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          if control_diag_left_black(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def showboard
    puts '--------------------'
    board.each do |row|
      puts "#{row} \n"
    end
  end
end

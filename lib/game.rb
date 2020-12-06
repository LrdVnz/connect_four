# frozen_string_literal: true

require_relative 'board'
require 'colorize'

class Game
  attr_accessor :winner, :board, :winner_token
  attr_reader :p1sign, :p2sign

  def initialize
    @winner = false
    @winner_token = nil
    @board = Board.new.board
  end

  def startgame
    puts 'Welcome to Connect Four !'.red
    puts 'This is your board.'
    showboard
    choose_sign
    loop do
      put_sign(p1sign)
      has_won?
      if @winner == true
        showboard
        puts "#{winner_token} WINS!" unless @winner_token.nil?
        return
      end
      showboard
      put_sign(p2sign)
      has_won?
      if @winner == true
        showboard
        puts "#{winner_token} WINS!" unless @winner_token.nil?
        return
      end
      showboard
    end
    puts "#{winner_token} WINS!" unless @winner_token.nil?
  end

  def choose_sign
    tokens = { '' => '', 'black' => '⚫', 'white' => '⚪' }
    puts "put 1 for #{tokens['black']}, 2 for #{tokens['white']}"
    input = verify_sign_input
    @p1sign = tokens.values[input]
    if p1sign == tokens['black']
      @p2sign = tokens['white']
    elsif p1sign == tokens['white']
      @p2sign = tokens['black']
    end
  end

  def verify_sign_input
    input = gets.chomp
    return input.to_i if input.match(/1|2/)
  end

  def put_sign(sign)
    puts 'Choose a column from 0 to 6 where to put your token'
    column_choice = verify_put_choice
    @board.reverse.each do |row|
      if row[column_choice] == '  '
        row[column_choice] = sign
        return
      end
    end
  end

  def verify_put_choice
    loop do
      choice = gets.chomp
      unless choice.match(/[0-6]/)
        puts 'choose a number between 0 and 6'
        next
      end
      num = choice.to_i
      if @board.all? { |row| row[num] != '  ' }
        puts 'Input Error! The chosen column is already occupied. Please choose another one'
      else
        return num
      end
    end
  end

  def has_won?
    board_full?
    check_horizontal_win
    check_vertical_win
    check_diagonal_left
    check_diagonal_right
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
          if control_1a(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          if control_1b(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def control_1a(index, i)
    if @board[index][i + 1] != nil && @board[index][i + 2] != nil && @board[index][i + 3] != nil
      @board[index][i + 1] == '⚪' && @board[index][i + 2] == '⚪' && @board[index][i + 3] == '⚪'
    end
  end

  def control_1b(index, i)
    if @board[index][i + 1] != nil && @board[index][i + 2] != nil && @board[index][i + 3] != nil
      @board[index][i + 1] == '⚫' && @board[index][i + 2] == '⚫' && @board[index][i + 3] == '⚫'
    end
  end

  def check_vertical_win
    @board.each_index do |index|
      i = 0
      while i < @board[index].length
        if @board[index][i] == '⚪'
          if control_2a(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          if control_2b(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def control_2a(index, i)
    if @board[index + 1] != nil && @board[index + 2] != nil && @board[index + 3] != nil
      if @board[index + 1][i] != nil && @board[index + 2][i] != nil && @board[index + 3][i] != nil
        @board[index + 1][i] == '⚪' && @board[index + 2][i] == '⚪' && @board[index + 3][i] == '⚪'
      end
    end
  end

  def control_2b(index, i)
    if @board[index + 1] != nil && @board[index + 2] != nil && @board[index + 3] != nil
      if @board[index + 1][i] != nil && @board[index + 2][i] != nil && @board[index + 3][i] != nil
        @board[index + 1][i] == '⚫' && @board[index + 2][i] == '⚫' && @board[index + 3][i] == '⚫'
      end
    end
  end

  def check_diagonal_right
    @board.each_index do |index| # <-- horizontal check
      i = 0
      while i < @board[index].length
        if @board[index][i] == '⚪'
          if control_3a(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          if control_3b(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def control_3a(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i - 1] != nil && @board[index - 2][i - 2] != nil && @board[index - 3][i - 3] != nil
        @board[index - 1][i - 1] == '⚪' && @board[index - 2][i - 2] == '⚪' && @board[index - 3][i - 3] == '⚪'
      end
    end
  end

  def control_3b(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i - 1] != nil && @board[index - 2][i - 2] != nil && @board[index - 3][i - 3] != nil
        @board[index - 1][i - 1] == '⚫' && @board[index - 2][i - 2] == '⚫' && @board[index - 3][i - 3] == '⚫'
      end
    end
  end

  def check_diagonal_left
    @board.each_index do |index| # <-- horizontal check
      i = 0
      while i < @board[index].length
        if @board[index][i] == '⚪'
          if control_4a(index, i) == true
            @winner_token = '⚪'
            return @winner = true
          end
        end
        if @board[index][i] == '⚫'
          if control_4b(index, i) == true
            @winner_token = '⚫'
            return @winner = true
          end
        end
        i += 1
      end
    end
  end

  def control_4a(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i + 1] != nil && @board[index - 2][i + 2] != nil && @board[index - 3][i + 3] != nil
        ccc = @board[index - 1][i + 1] == '⚪' && @board[index - 2][i + 2] == '⚪' && @board[index - 3][i + 3] == '⚪'
      end
    end
  end

  def control_4b(index, i)
    if @board[index - 1] != nil && @board[index - 2] != nil && @board[index - 3] != nil
      if @board[index - 1][i + 1] != nil && @board[index - 2][i + 2] != nil && @board[index - 3][i + 3] != nil
        @board[index - 1][i + 1] == '⚫' && @board[index - 2][i + 2] == '⚫' && @board[index - 3][i + 3] == '⚫'
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

#g = Game.new
#g.startgame

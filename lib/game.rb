# frozen_string_literal: true

require_relative 'board'
require 'colorize'

# main Game class, for starting the game, looping etc
class Game < Board
  attr_accessor :winner, :board, :winner_token, :tokens
  attr_reader :p1sign, :p2sign

  def initialize
    super
    @winner = false
    @winner_token = nil
    @board = Board.new.board
  end

  def startgame
    puts 'Welcome to Connect Four !'
    puts 'This is your board.'
    showboard
    choose_sign
    game_loop
  end

  def game_loop
    loop do
      call_p1put
      return show_winner if @winner == true

      call_p2put
      return show_winner if @winner == true
    end
  end

  def call_p1put
    put_sign(p1sign)
    won?
    showboard
  end

  def call_p2put
    put_sign(p2sign)
    won?
    showboard
  end

  def show_winner
    showboard
    puts "#{winner_token} WINS!" unless @winner_token.nil?
  end

  def choose_sign
    @tokens = { '' => '', 'black' => '⚫', 'white' => '⚪' }
    puts "put 1 for #{tokens['black']}, 2 for #{tokens['white']}"
    input = verify_sign_input
    assign_token(input, tokens)
  end

  def assign_token(input, tokens)
    @p1sign = tokens.values[input]
    if p1sign == tokens['black']
      @p2sign = tokens['white']
    elsif p1sign == tokens['white']
      @p2sign = tokens['black']
    end
  end

  def verify_sign_input
    loop do
      input = gets.chomp
      return input.to_i if input.match(/1|2/)

      puts "put 1 for #{tokens['black']}, 2 for #{tokens['white']}"
    end
  end

  def put_sign(sign)
    puts 'Choose a column from 0 to 6 where to put your token'
    column_choice = verify_put_choice
    @board.reverse.each do |row|
      if row[column_choice] == '  '
        row[column_choice] = sign
        break
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
      return num unless @board.all? { |row| row[num] != '  ' }

      puts 'Input Error! The chosen column is already occupied. Please choose another one'
    end
  end

  def won?
    board_full?
    check_horizontal_win
    check_vertical_win
    check_diagonal_left
    check_diagonal_right
  end
end

Game.new.startgame

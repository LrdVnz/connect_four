# frozen_string_literal: true

class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    dummy_board = []
    6.times do
      row = []
      dummy_board << row
    end

    dummy_board.each do |row|
      7.times do |_i|
        cell = '  '
        row << cell
      end
    end
  end
end

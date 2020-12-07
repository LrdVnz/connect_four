# frozen_string_literal: true

require './lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_new) { described_class.new }

    it 'should create board as array' do
      expect(board_new.board).to be_instance_of(Array)
    end
  end

  describe '#create board' do
    subject(:board_create) { described_class.new }

    context 'using a multilevel array' do
      it 'creates a board with 6 rows' do
        expect(board_create.board.length).to be(6)
      end

      it 'creates board with 7 columns' do
        expect(board_create.board.all? { |row| row.length == 7 }).to eq(true)
      end
    end
  end
end

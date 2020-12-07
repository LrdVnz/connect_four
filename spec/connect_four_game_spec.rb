# frozen_string_literal: true

require './lib/game'

describe Game do
  describe '#initialize' do
    subject(:game_new) { described_class.new }

    it 'creates winner with false' do
      expect(game_new.winner).to eq(false)
    end

    it 'creates new board' do
      expect(game_new.board).to be_instance_of(Array)
    end
  end

  describe '#startgame' do
    subject(:game_startgame) { described_class.new }
    let(:tokens) { { 'black' => '⚫', 'white' => '⚪' } }

    context 'when winner is true and there is a winner token' do
      before do
        welcome_message = 'Welcome to Connect Four !'
        show_message = 'This is your board.'
        choose_sign_message = "put 1 for #{tokens['black']}, 2 for #{tokens['white']}"
        allow(game_startgame).to receive(:puts).with(welcome_message)
        allow(game_startgame).to receive(:puts).with(show_message)
        allow(game_startgame).to receive(:puts).with(choose_sign_message)
        allow(game_startgame).to receive_message_chain(:choose_sign)
        allow(game_startgame).to receive(:showboard)
        allow(game_startgame).to receive(:put_sign)
      end

      it 'stops and shows winning message' do
        game_startgame.winner_token = '⚪'
        win_message = "#{game_startgame.winner_token} WINS!"
        game_startgame.winner = true
        expect(game_startgame).to receive(:puts).with(win_message)
        game_startgame.startgame
      end
    end
  end

  describe '#verify_input' do
    subject(:game_verify_input) { described_class.new }

    context 'when input is invalid' do
      it 'returns nil' do
        invalid_input = '4'
        allow(game_verify_input).to receive(:gets).and_return(invalid_input)
        expect(game_verify_input).to receive(:verify_input).and_return(nil)
        game_verify_input.verify_input
      end
    end

    context 'when input is valid' do
      it 'returns the input turned to integer' do
        valid_input = '2'
        allow(game_verify_input).to receive(:gets).and_return(valid_input)
        expect(game_verify_input).to receive(:verify_input).and_return(2)
        game_verify_input.verify_input
      end
    end
  end

  describe '#choose_sign' do
    subject(:game_choose_sign) { described_class.new }

    context 'when input is 2' do
      it 'makes p1sign ⚪' do
        input = 2
        allow(game_choose_sign).to receive(:verify_sign_input).and_return(input)
        game_choose_sign.choose_sign
        expect(game_choose_sign.p1sign).to eq('⚪')
      end

      it 'makes p2sign ⚫ ' do
        input = 2
        allow(game_choose_sign).to receive(:verify_sign_input).and_return(input)
        game_choose_sign.choose_sign
        expect(game_choose_sign.p2sign).to eq('⚫')
      end
    end

    context 'when input is 1' do
      it 'makes p1sign ⚫' do
        input = 1
        allow(game_choose_sign).to receive(:verify_sign_input).and_return(input)
        game_choose_sign.choose_sign
        expect(game_choose_sign.p1sign).to eq('⚫')
      end

      it 'makes p2sign ⚪' do
        input = 1
        allow(game_choose_sign).to receive(:verify_sign_input).and_return(input)
        game_choose_sign.choose_sign
        expect(game_choose_sign.p2sign).to eq('⚪')
      end
    end
  end

  describe '#put sign' do
    subject(:game_put_sign) { described_class.new }
    let(:p1sign) { '⚪' }
    let(:board_arr) { game_put_sign.instance_variable_get(:@board) }
    # board[5][0] ---> the first(5) is the row. the second [0] is the column
    context 'when a sign choses a free column' do
      before do
        player_choice = 0
        allow(game_put_sign).to receive(:puts)
        allow(game_put_sign).to receive(:verify_put_choice).and_return(player_choice)
      end

      it 'puts sign to the last free row' do
        player_choice = 0
        game_put_sign.put_sign(p1sign)
        expect(board_arr[5][player_choice]).to eq('⚪')
      end

      it "doesn't put sign to the second last free row" do
        player_choice = 0
        game_put_sign.put_sign(p1sign)
        expect(board_arr[4][player_choice]).not_to eq('⚪')
      end
    end

    context 'when sign chooses a column where the last row is occupied ' do
      before do
        player_choice = 1
        allow(game_put_sign).to receive(:puts)
        allow(game_put_sign).to receive(:verify_put_choice).and_return(player_choice)
      end

      it 'puts the sign to the second-last row' do
        player_choice = 1
        board_arr[5][player_choice] = '⚪'
        game_put_sign.put_sign(p1sign)
        expect(game_put_sign.board[4][player_choice]).to eq('⚪')
      end

      it "doesn't put sign to the third-last row" do
        player_choice = 1
        board_arr[5][player_choice] = '⚪'
        game_put_sign.put_sign(p1sign)
        expect(game_put_sign.board[3][player_choice]).not_to eq('⚪')
      end
    end

    context 'when sign chooses a column with the last 2 rows occupied' do
      before do
        player_choice = 6
        allow(game_put_sign).to receive(:puts)
        allow(game_put_sign).to receive(:verify_put_choice).and_return(player_choice)
      end

      it 'works as expected, putting sign in third row ' do
        player_choice = 6
        board_arr[5][player_choice] = '⚪'
        board_arr[4][player_choice] = '⚪'
        board_arr[3][player_choice] = '⚪'
        game_put_sign.put_sign(p1sign)
        expect(game_put_sign.board[2][player_choice]).to eq('⚪')
      end

      it "doesn't put sign to the second row " do
        player_choice = 6
        board_arr[5][player_choice] = '⚪'
        board_arr[4][player_choice] = '⚪'
        board_arr[3][player_choice] = '⚪'
        game_put_sign.put_sign(p1sign)
        expect(game_put_sign.board[2][player_choice]).to eq('⚪')
      end
    end
  end

  describe '#verify_put_choice' do
    subject(:game_verify_put) { described_class.new }
    let(:p1sign) { '⚪' }

    context 'when sign chooses a colum with all rows occupied once, then a free one' do
      before do
        wrong_choice = '4'
        right_choice = '3'
        game_verify_put.instance_variable_set(:@p1sign, '⚪')
        choose_message = 'Choose a column from 0 to 6 where to put your token'
        allow(game_verify_put).to receive(:puts).with(choose_message)
        allow(game_verify_put).to receive(:gets).and_return(wrong_choice, right_choice)
      end

      it 'puts the error message and continues the loop' do
        player_choice = 4
        game_verify_put.board.each do |row|
          row[player_choice] = '⚪'
        end
        error_message = 'Input Error! The chosen column is already occupied. Please choose another one'
        expect(game_verify_put).to receive(:puts).with(error_message)
        game_verify_put.put_sign(p1sign)
      end

      context 'when sign chooses a colum with all rows occupied twice, then a free one' do
        before do
          wrong_choice = '4'
          right_choice = '3'
          game_verify_put.instance_variable_set(:@p1sign, '⚪')
          choose_message = 'Choose a column from 0 to 6 where to put your token'
          allow(game_verify_put).to receive(:puts).with(choose_message)
          allow(game_verify_put).to receive(:gets).and_return(wrong_choice, wrong_choice, right_choice)
        end

        it 'puts the error message twice and continues the loop' do
          player_choice = 4
          game_verify_put.board.each do |row|
            row[player_choice] = '⚪'
          end
          error_message = 'Input Error! The chosen column is already occupied. Please choose another one'
          expect(game_verify_put).to receive(:puts).with(error_message).twice
          game_verify_put.put_sign(p1sign)
        end
      end
    end

    describe '#board_full' do
      subject(:game_board_full) { described_class.new }

      context 'when board is full' do
        it 'makes winner true' do
          game_board_full.board.map! { |row| row.map { |_element| element = '⚪' } }
          full_message = 'board is full'
          expect(game_board_full).to receive(:puts).with(full_message)
          game_board_full.board_full?
          expect(game_board_full.winner).to be(true)
        end
      end
    end

    describe '#check_horizontal_win' do
      subject(:game_check_horizontal) { described_class.new }

      context 'when four tokens are lined up horizontally' do
        it 'makes winner true' do
          game_check_horizontal.board[5][-1] = '⚫'
          game_check_horizontal.board[5][-2] = '⚫'
          game_check_horizontal.board[5][-3] = '⚫'
          game_check_horizontal.board[5][-4] = '⚫'
          game_check_horizontal.check_horizontal_win
          expect(game_check_horizontal.winner).to be(true)
        end

        it 'works with different row and white token' do
          game_check_horizontal.board[3][-1] = '⚪'
          game_check_horizontal.board[3][-2] = '⚪'
          game_check_horizontal.board[3][-3] = '⚪'
          game_check_horizontal.board[3][-4] = '⚪'
          game_check_horizontal.check_horizontal_win
          expect(game_check_horizontal.winner).to be(true)
        end
      end
    end

    describe '#check_vertical_win' do
      subject(:game_check_vertical) { described_class.new }

      context 'when four tokens are lined up horizontally' do
        it 'makes winner true' do
          game_check_vertical.board[5][2] = '⚫'
          game_check_vertical.board[4][2] = '⚫'
          game_check_vertical.board[3][2] = '⚫'
          game_check_vertical.board[2][2] = '⚫'
          game_check_vertical.check_vertical_win
          expect(game_check_vertical.winner).to be(true)
        end

        it 'works with different row and white token' do
          game_check_vertical.board[3][4] = '⚪'
          game_check_vertical.board[2][4] = '⚪'
          game_check_vertical.board[1][4] = '⚪'
          game_check_vertical.board[0][4] = '⚪'
          game_check_vertical.check_vertical_win
          expect(game_check_vertical.winner).to be(true)
        end
      end
    end

    describe '#check_diagonal_right' do
      subject(:game_right_diagonal) { described_class.new }

      context 'when four tokens are lined up horizontally' do
        it 'makes winner true' do
          game_right_diagonal.board[5][3] = '⚫'
          game_right_diagonal.board[4][2] = '⚫'
          game_right_diagonal.board[3][1] = '⚫'
          game_right_diagonal.board[2][0] = '⚫'
          game_right_diagonal.check_diagonal_right
          expect(game_right_diagonal.winner).to be(true)
        end

        it 'works with different row and white token' do
          game_right_diagonal.board[3][4] = '⚪'
          game_right_diagonal.board[2][3] = '⚪'
          game_right_diagonal.board[1][2] = '⚪'
          game_right_diagonal.board[0][1] = '⚪'
          game_right_diagonal.check_diagonal_right
          expect(game_right_diagonal.winner).to be(true)
        end
      end
    end

    describe '#check_diagonal_right' do
      subject(:game_left_diagonal) { described_class.new }

      context 'when four tokens are lined up horizontally' do
        it 'makes winner true' do
          game_left_diagonal.board[2][5] = '⚫'
          game_left_diagonal.board[3][4] = '⚫'
          game_left_diagonal.board[4][3] = '⚫'
          game_left_diagonal.board[5][2] = '⚫'
          game_left_diagonal.check_diagonal_left
          expect(game_left_diagonal.winner).to be(true)
        end

        it 'works with different row and white token' do
          game_left_diagonal.board[1][4] = '⚪'
          game_left_diagonal.board[2][3] = '⚪'
          game_left_diagonal.board[3][2] = '⚪'
          game_left_diagonal.board[4][1] = '⚪'
          game_left_diagonal.check_diagonal_left
          expect(game_left_diagonal.winner).to be(true)
        end
      end
    end
  end
end

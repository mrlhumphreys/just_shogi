require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/square'
require 'just_shogi/pieces/fuhyou'

describe JustShogi::Square do
  describe '#initialize' do
    it 'initializes the attributes' do
      square = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: { id: 1, player_number: 2, type: 'fuhyou' })
      assert_instance_of JustShogi::Fuhyou, square.piece
    end
  end

  describe '#promotion_zone' do
    describe 'when player 1' do
      describe 'and in lower ranks' do
        it 'returns true' do
          square = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: nil) 
          player_number = 1
          assert square.promotion_zone(player_number)
        end
      end

      describe 'and it upper ranks' do
        it 'returns false' do
          square = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil) 
          player_number = 1
          refute square.promotion_zone(player_number)
        end
      end
    end

    describe 'when player 2' do
      describe 'and in lower ranks' do
        it 'returns true' do
          square = JustShogi::Square.new(id: '57', x: 4, y: 6, piece: nil) 
          player_number = 2 
          assert square.promotion_zone(player_number)
        end
      end

      describe 'and in upper ranks' do
        it 'returns true' do
          square = JustShogi::Square.new(id: '56', x: 4, y: 5, piece: nil) 
          player_number = 2 
          refute square.promotion_zone(player_number)
        end
      end
    end

    describe 'when invalid player' do
      it 'raises error' do
        square = JustShogi::Square.new(id: '56', x: 4, y: 5, piece: nil) 
        player_number = 3 
        assert_raises(ArgumentError) do
          square.promotion_zone(player_number)
        end
      end
    end
  end
end

require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/hand'

describe JustShogi::Hand do
  describe '#initialize' do
    describe 'given an array of hashes' do
      it 'builds the pieces based on the hashes' do
        JustShogi::Hand.new(player_number: 1, pieces: [
          { id: 1, player_number: 1, type: 'fuhyou' },
          { id: 2, player_number: 2, type: 'fuhyou' }
        ])
      end
    end

    describe 'given an array of pieces' do
      it 'sets the pieces to the given pieces' do
        JustShogi::Hand.new(player_number: 1, pieces: [
          JustShogi::Fuhyou.new(id: 1, player_number: 1),
          JustShogi::Fuhyou.new(id: 2, player_number: 2)
        ])
      end
    end

    describe 'given a mix of objects' do
      it 'raises an error' do
        assert_raises(ArgumentError) do
          JustShogi::Hand.new(player_number: 1, pieces: [
            JustShogi::Fuhyou.new(id: 1, player_number: 1),
            { id: 2, player_number: 2, type: 'fuhyou' }
          ])
        end
      end
    end

    describe 'given not an array' do
      it 'raises an error' do
        assert_raises(ArgumentError) do
          JustShogi::Hand.new(player_number: 1, pieces: 'array')
        end
      end
    end
  end

  describe '#push_piece' do
    it 'adds the piece to the hand' do
      hand = JustShogi::Hand.new(player_number: 1, pieces: [])
      piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)

      hand.push_piece(piece)

      assert_includes hand.pieces, piece
    end

    it 'changes the ownership of the piece' do
      hand = JustShogi::Hand.new(player_number: 1, pieces: [])
      piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)

      hand.push_piece(piece)
      
      assert_equal 2, hand.pieces.first.player_number
    end

    it 'demotes the piece' do
      hand = JustShogi::Hand.new(player_number: 1, pieces: [])
      piece = JustShogi::Tokin.new(id: 1, player_number: 1)

      hand.push_piece(piece)
      
      assert_instance_of JustShogi::Fuhyou, hand.pieces.first
    end
  end

  describe '#pop_piece' do
    it 'removes the piece from the hand' do
      piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)
      hand = JustShogi::Hand.new(player_number: 1, pieces: [piece])

      hand.pop_piece(piece.id)

      refute_includes hand.pieces, piece
    end

    it 'returns the piece' do
      piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)
      hand = JustShogi::Hand.new(player_number: 1, pieces: [piece])

      result = hand.pop_piece(piece.id)

      assert_equal piece, result
    end
  end

  describe '#find_piece_by_id' do
    describe 'with valid id' do
      it 'returns the piece' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)
        hand = JustShogi::Hand.new(player_number: 1, pieces: [piece])

        assert_equal piece, hand.find_piece_by_id(1)
      end
    end

    describe 'with invalid id' do
      it 'returns nil' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)
        hand = JustShogi::Hand.new(player_number: 1, pieces: [piece])

        assert_nil hand.find_piece_by_id(2)
      end
    end
  end

  describe '#as_json' do
    it 'serializes the hand as a hash' do
      piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)
      hand = JustShogi::Hand.new(player_number: 1, pieces: [piece])

      expected = {
        player_number: 1,
        pieces: [
          { id: 1, player_number: 1, type: 'fuhyou' }
        ]
      }
      result = hand.as_json

      assert_equal expected, result
    end
  end
end

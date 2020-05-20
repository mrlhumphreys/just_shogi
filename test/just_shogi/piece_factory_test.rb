require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/fuhyou'
require 'just_shogi/piece_factory'

describe JustShogi::PieceFactory do
  describe '.build' do
    describe 'given a hash' do
      it 'returns a piece with attributes specified in the hash' do
        piece = { id: 1, player_number: 2, type: 'fuhyou' }
        factory = JustShogi::PieceFactory.new(piece)
        result = factory.build

        assert_instance_of JustShogi::Fuhyou, result 
        assert_equal 1, result.id
        assert_equal 2, result.player_number
      end
    end

    describe 'given a piece' do
      it 'returns the piece passed in' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 2)
        factory = JustShogi::PieceFactory.new(piece)
        assert_equal piece, factory.build
      end
    end

    describe 'given nil' do
      it 'returns nil' do
        piece = nil
        factory = JustShogi::PieceFactory.new(piece)
        assert_nil factory.build
      end
    end

    describe 'given unexpected input' do
      it 'raises error' do
        piece = 'fuhyou' 
        factory = JustShogi::PieceFactory.new(piece)
        assert_raises(ArgumentError) do 
          factory.build
        end
      end
    end
  end
end


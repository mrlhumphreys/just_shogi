require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/square_set'

describe JustShogi::SquareSet do
  describe '#initialize' do
    describe 'when all hashes' do
      it 'returns the square set' do
        square_set = JustShogi::SquareSet.new(squares: [
          { id: '55', x: 4, y: 4, piece: nil },
          { id: '54', x: 4, y: 3, piece: nil }
        ])

        first_square = square_set.squares[0]

        assert_instance_of JustShogi::SquareSet, square_set
        assert_equal 2, square_set.squares.size
        assert_instance_of JustShogi::Square, first_square
      end
    end

    describe 'when all squares' do
      it 'returns the square set' do
        square_set = JustShogi::SquareSet.new(squares: [
          JustShogi::Square.new({ id: '55', x: 4, y: 4, piece: nil }),
          JustShogi::Square.new({ id: '54', x: 4, y: 3, piece: nil })
        ])

        first_square = square_set.squares[0]

        assert_instance_of JustShogi::SquareSet, square_set
        assert_equal 2, square_set.squares.size
        assert_instance_of JustShogi::Square, first_square
      end
    end

    describe 'when mismatched' do
      it 'raises an error' do
        assert_raises(ArgumentError) do
          JustShogi::SquareSet.new(squares: [
            { id: '55', x: 4, y: 4, piece: nil },
            JustShogi::Square.new({ id: '54', x: 4, y: 3, piece: nil })
          ])
        end
      end
    end

    describe 'when not an array' do
      it 'raises an error' do
        assert_raises(ArgumentError) do
          JustShogi::SquareSet.new(squares: 'string')
        end
      end
    end
  end

  describe '#find_ou_for_player' do
    it 'returns the ou for that player' do
      square_set = JustShogi::SquareSet.new(squares: [
        { id: '55', x: 4, y: 4, piece: nil },
        { id: '54', x: 4, y: 3, piece: { id: 1, player_number: 1, type: 'oushou' } }
      ])

      result = square_set.find_ou_for_player(1)

      assert_instance_of JustShogi::Oushou, result
      assert_equal 1, result.player_number
    end
  end

  describe '#threatened_by' do
    it 'returns squares that are threatened by the player' do
      origin = JustShogi::Square.new({ id: '54', x: 4, y: 3, piece: { id: 1, player_number: 2, type: 'fuhyou' } })
      threat = JustShogi::Square.new({ id: '55', x: 4, y: 4, piece: nil })
      not_threat = JustShogi::Square.new({ id: '56', x: 4, y: 5, piece: nil })
      square_set = JustShogi::SquareSet.new(squares: [ origin, threat, not_threat ])

      result = square_set.threatened_by(2)

      assert_includes threat, result 
      refute_includes not_threat, result 
    end
  end
end

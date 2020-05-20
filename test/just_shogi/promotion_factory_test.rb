require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/fuhyou'
require 'just_shogi/pieces/tokin'
require 'just_shogi/pieces/kinshou'
require 'just_shogi/promotion_factory'

describe JustShogi::PromotionFactory do
  describe '.new' do
    describe 'when given a promotable or demotable piece' do
      it 'initializes' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 1)
        factory = JustShogi::PromotionFactory.new(piece)

        assert_instance_of JustShogi::PromotionFactory, factory
      end
    end
  end

  describe '#promotable?' do
    describe 'when given a promotable piece' do
      it 'returns true' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        assert factory.promotable?
      end
    end

    describe 'when given a non-promotable piece' do
      it 'returns false' do
        piece = JustShogi::Tokin.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        refute factory.promotable?
      end
    end
  end

  describe '#demotable?' do
    describe 'when given a demotable piece' do
      it 'returns true' do
        piece = JustShogi::Tokin.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        assert factory.demotable?
      end
    end

    describe 'when given a non-demotable piece' do
      it 'returns false' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        refute factory.demotable?
      end
    end
  end

  describe '#promote' do
    describe 'when given a promotable piece' do
      it 'returns the promoted piece' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        result = factory.promote

        assert_instance_of JustShogi::Tokin, result
        assert_equal 1, result.id
        assert_equal 2, result.player_number
      end
    end

    describe 'when given a non-promotable piece' do
      it 'raises an error' do
        piece = JustShogi::Tokin.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        assert_raises(ArgumentError) do
          factory.promote
        end
      end
    end
  end

  describe '#demote' do
    describe 'when given a demotable piece' do
      it 'returns the demoted piece' do
        piece = JustShogi::Tokin.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        result = factory.demote

        assert_instance_of JustShogi::Fuhyou, result
        assert_equal 1, result.id
        assert_equal 2, result.player_number
      end
    end

    describe 'when given a non-demotable piece' do
      it 'raises an error' do
        piece = JustShogi::Fuhyou.new(id: 1, player_number: 2)
        factory = JustShogi::PromotionFactory.new(piece)

        assert_raises(ArgumentError) do
          factory.demote
        end
      end
    end
  end
end

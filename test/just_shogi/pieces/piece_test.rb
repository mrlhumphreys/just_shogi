require 'minitest/autorun'
require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/piece'

describe JustShogi::Piece do
  describe '#initialize' do
    it 'makes a new piece' do
      piece = JustShogi::Piece.new(id: 1, player_number: 2)
      assert_instance_of JustShogi::Piece, piece
    end
  end

  describe 'switch_player' do
    it 'changes the player number to the other player' do
      piece = JustShogi::Piece.new(id: 1, player_number: 2)
      piece.switch_player

      assert_equal 1, piece.player_number
    end
  end

  describe 'has_legal_moves_from_y' do
    it 'must return true' do
      piece = JustShogi::Piece.new(id: 1, player_number: 2)
      result = piece.has_legal_moves_from_y(1) 
      assert result
    end
  end
end

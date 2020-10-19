require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/kyousha'

describe JustShogi::Kyousha do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      kyousha = JustShogi::Kyousha.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: kyousha) 
      near = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil) 
      far = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: nil) 
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, near, far, side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kyousha.destinations(from, game_state)

      assert_includes(result, near)
      assert_includes(result, far)
      refute_includes(result, side)
    end

    it 'returns the squares it can move to if occupied by opponent' do
      kyousha = JustShogi::Kyousha.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: kyousha) 

      near_piece = JustShogi::Kyousha.new(id: 2, player_number: 2)
      near = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: near_piece) 

      far_piece = JustShogi::Kyousha.new(id: 3, player_number: 2)
      far = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: far_piece) 

      side_piece = JustShogi::Kyousha.new(id: 4, player_number: 2)
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: side_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, near, far, side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kyousha.destinations(from, game_state)

      assert_includes(result, near)
      refute_includes(result, far)
      refute_includes(result, side)
    end

    it 'does not return squares that are blocked' do
      kyousha = JustShogi::Kyousha.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: kyousha) 

      near_piece = JustShogi::Kyousha.new(id: 2, player_number: 1)
      near = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: near_piece) 

      far_piece = JustShogi::Kyousha.new(id: 3, player_number: 1)
      far = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: far_piece) 

      side_piece = JustShogi::Kyousha.new(id: 4, player_number: 1)
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: side_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, near, far, side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kyousha.destinations(from, game_state)

      refute_includes(result, near)
      refute_includes(result, far)
      refute_includes(result, side)
    end
  end

  describe 'has_legal_moves_from_y' do
    describe 'when player 1' do
      describe 'when y is 0' do
        it 'must return false' do
          kyousha = JustShogi::Kyousha.new(id: 1, player_number: 1)
          result = kyousha.has_legal_moves_from_y(0)

          refute result 
        end
      end

      describe 'when y is not 0' do
        it 'must return true' do
          kyousha = JustShogi::Kyousha.new(id: 1, player_number: 1)
          result = kyousha.has_legal_moves_from_y(1)

          assert result 
        end
      end
    end

    describe 'when player 2' do
      describe 'when y is 8' do
        it 'must return false' do
          kyousha = JustShogi::Kyousha.new(id: 1, player_number: 2)
          result = kyousha.has_legal_moves_from_y(8)

          refute result 
        end
      end

      describe 'when y is not 8' do
        it 'must return true' do
          kyousha = JustShogi::Kyousha.new(id: 1, player_number: 2)
          result = kyousha.has_legal_moves_from_y(7)

          assert result 
        end
      end
    end
  end
end

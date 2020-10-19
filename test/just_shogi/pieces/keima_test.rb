require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/keima'

describe JustShogi::Keima do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      keima = JustShogi::Keima.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece:keima) 

      far_front_left = JustShogi::Square.new(id: '74', x: 2, y: 3, piece: nil) 
      far_back_left = JustShogi::Square.new(id: '76', x: 2, y: 5, piece: nil) 
      front_left = JustShogi::Square.new(id: '63', x: 3, y: 2, piece: nil)
      front_right = JustShogi::Square.new(id: '43', x: 5, y: 2, piece: nil)
      far_back_right = JustShogi::Square.new(id: '55', x: 6, y: 5, piece: nil) 
      far_front_right = JustShogi::Square.new(id: '36', x: 6, y: 3, piece: nil)
      back_left = JustShogi::Square.new(id: '67', x: 3, y: 6, piece: nil) 
      back_right = JustShogi::Square.new(id: '47', x: 5, y: 6, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, far_back_left, far_back_right, front_left, front_right, far_front_left, far_front_right, back_left, back_right])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = keima.destinations(from, game_state)

      assert_includes(result, front_left)
      assert_includes(result, front_right)
      refute_includes(result, far_back_left)
      refute_includes(result, far_back_right)
      refute_includes(result, far_front_left)
      refute_includes(result, far_front_right)
      refute_includes(result, back_left)
      refute_includes(result, back_right)
    end

    it 'returns the squares it can move to if occupied by opponent' do
      keima = JustShogi::Keima.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece:keima) 

      far_front_left_piece = JustShogi::Keima.new(id: 2, player_number: 2)
      far_front_left = JustShogi::Square.new(id: '74', x: 2, y: 3, piece: far_front_left_piece) 

      far_back_left_piece = JustShogi::Keima.new(id: 3, player_number: 2)
      far_back_left = JustShogi::Square.new(id: '76', x: 2, y: 5, piece: far_back_left_piece) 

      front_left_piece = JustShogi::Keima.new(id: 4, player_number: 2)
      front_left = JustShogi::Square.new(id: '63', x: 3, y: 2, piece: front_left_piece)

      front_right_piece = JustShogi::Keima.new(id: 5, player_number: 2)
      front_right = JustShogi::Square.new(id: '43', x: 5, y: 2, piece: front_right_piece)

      far_back_right_piece = JustShogi::Keima.new(id: 6, player_number: 2)
      far_back_right = JustShogi::Square.new(id: '55', x: 6, y: 5, piece: far_back_right_piece) 

      far_front_right_piece = JustShogi::Keima.new(id: 7, player_number: 2)
      far_front_right = JustShogi::Square.new(id: '36', x: 6, y: 3, piece: far_front_right_piece)

      back_left_piece = JustShogi::Keima.new(id: 8, player_number: 2)
      back_left = JustShogi::Square.new(id: '67', x: 3, y: 6, piece: back_left_piece) 

      back_right_piece = JustShogi::Keima.new(id: 9, player_number: 2)
      back_right = JustShogi::Square.new(id: '47', x: 5, y: 6, piece: back_right_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, far_back_left, far_back_right, front_left, front_right, far_front_left, far_front_right, back_left, back_right])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = keima.destinations(from, game_state)

      assert_includes(result, front_left)
      assert_includes(result, front_right)
      refute_includes(result, far_back_left)
      refute_includes(result, far_back_right)
      refute_includes(result, far_front_left)
      refute_includes(result, far_front_right)
      refute_includes(result, back_left)
      refute_includes(result, back_right)
    end

    it 'does not return blocked squares' do
      keima = JustShogi::Keima.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece:keima) 

      far_front_left_piece = JustShogi::Keima.new(id: 2, player_number: 1)
      far_front_left = JustShogi::Square.new(id: '74', x: 2, y: 3, piece: far_front_left_piece) 

      far_back_left_piece = JustShogi::Keima.new(id: 3, player_number: 1)
      far_back_left = JustShogi::Square.new(id: '76', x: 2, y: 5, piece: far_back_left_piece) 

      front_left_piece = JustShogi::Keima.new(id: 4, player_number: 1)
      front_left = JustShogi::Square.new(id: '63', x: 3, y: 2, piece: front_left_piece)

      front_right_piece = JustShogi::Keima.new(id: 5, player_number: 1)
      front_right = JustShogi::Square.new(id: '43', x: 5, y: 2, piece: front_right_piece)

      far_back_right_piece = JustShogi::Keima.new(id: 6, player_number: 1)
      far_back_right = JustShogi::Square.new(id: '55', x: 6, y: 5, piece: far_back_right_piece) 

      far_front_right_piece = JustShogi::Keima.new(id: 7, player_number: 1)
      far_front_right = JustShogi::Square.new(id: '36', x: 6, y: 3, piece: far_front_right_piece)

      back_left_piece = JustShogi::Keima.new(id: 8, player_number: 1)
      back_left = JustShogi::Square.new(id: '67', x: 3, y: 6, piece: back_left_piece) 

      back_right_piece = JustShogi::Keima.new(id: 9, player_number: 1)
      back_right = JustShogi::Square.new(id: '47', x: 5, y: 6, piece: back_right_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, far_back_left, far_back_right, front_left, front_right, far_front_left, far_front_right, back_left, back_right])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = keima.destinations(from, game_state)

      refute_includes(result, front_left)
      refute_includes(result, front_right)
      refute_includes(result, far_back_left)
      refute_includes(result, far_back_right)
      refute_includes(result, far_front_left)
      refute_includes(result, far_front_right)
      refute_includes(result, back_left)
      refute_includes(result, back_right)
    end
  end

  describe '#has_legal_moves_from_y' do
    describe 'when player 1' do
      describe 'when greater than 1' do
        it 'must return true' do
          keima = JustShogi::Keima.new(id: 1, player_number: 1)
          result = keima.has_legal_moves_from_y(2)
          assert result
        end
      end

      describe 'when 1' do
        it 'must return false' do
          keima = JustShogi::Keima.new(id: 1, player_number: 1)
          result = keima.has_legal_moves_from_y(1)
          refute result
        end
      end

      describe 'when less than 1' do
        it 'must return false' do
          keima = JustShogi::Keima.new(id: 1, player_number: 1)
          result = keima.has_legal_moves_from_y(0)
          refute result
        end
      end
    end

    describe 'when player 2' do
      describe 'when greater than 7' do
        it 'must return false' do
          keima = JustShogi::Keima.new(id: 1, player_number: 2)
          result = keima.has_legal_moves_from_y(8)
          refute result
        end
      end

      describe 'when 7' do
        it 'must return false' do
          keima = JustShogi::Keima.new(id: 1, player_number: 2)
          result = keima.has_legal_moves_from_y(7)
          refute result
        end
      end

      describe 'when less than 7' do
        it 'must return true' do
          keima = JustShogi::Keima.new(id: 1, player_number: 2)
          result = keima.has_legal_moves_from_y(6)
          assert result
        end
      end
    end
  end
end

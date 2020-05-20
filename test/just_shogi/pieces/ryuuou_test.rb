require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/ryuuou'

describe JustShogi::Ryuuou do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      ryuuou = JustShogi::Ryuuou.new(id: 1, player_number: 1)

      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: ryuuou) 
      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil) 
      far_forward = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: nil) 
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: nil) 
      far_diagonal = JustShogi::Square.new(id: '33', x: 6, y: 2, piece: nil) 
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: nil) 
      far_side = JustShogi::Square.new(id: '35', x: 6, y: 4, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, far_forward, diagonal, far_diagonal, side, far_side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ryuuou.destinations(from, game_state)

      assert_includes(result, forward)
      assert_includes(result, far_forward)
      assert_includes(result, diagonal)
      refute_includes(result, far_diagonal)
      assert_includes(result, side)
      assert_includes(result, far_side)
    end

    it 'returns the squares it can move to if occupied by opponent' do
      ryuuou = JustShogi::Ryuuou.new(id: 1, player_number: 1)

      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: ryuuou) 

      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil) 

      far_forward_piece = JustShogi::Ryuuou.new(id: 2, player_number: 2)
      far_forward = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: far_forward_piece) 

      diagonal_piece = JustShogi::Ryuuou.new(id: 3, player_number: 2)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_piece) 

      far_diagonal = JustShogi::Square.new(id: '33', x: 6, y: 2, piece: nil) 

      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: nil) 

      far_side_piece = JustShogi::Ryuuou.new(id: 4, player_number: 2)
      far_side = JustShogi::Square.new(id: '35', x: 6, y: 4, piece: far_side_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, far_forward, diagonal, far_diagonal, side, far_side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ryuuou.destinations(from, game_state)

      assert_includes(result, forward)
      assert_includes(result, far_forward)
      assert_includes(result, diagonal)
      refute_includes(result, far_diagonal)
      assert_includes(result, side)
      assert_includes(result, far_side)
    end

    it 'does not return squares that are blocked' do
      ryuuou = JustShogi::Ryuuou.new(id: 1, player_number: 1)

      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: ryuuou) 

      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil) 

      far_forward_piece = JustShogi::Ryuuou.new(id: 2, player_number: 1)
      far_forward = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: far_forward_piece) 

      diagonal_piece = JustShogi::Ryuuou.new(id: 3, player_number: 1)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_piece) 

      far_diagonal = JustShogi::Square.new(id: '33', x: 6, y: 2, piece: nil) 

      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: nil) 

      far_side_piece = JustShogi::Ryuuou.new(id: 4, player_number: 1)
      far_side = JustShogi::Square.new(id: '35', x: 6, y: 4, piece: far_side_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, far_forward, diagonal, far_diagonal, side, far_side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ryuuou.destinations(from, game_state)

      assert_includes(result, forward)
      refute_includes(result, far_forward)
      refute_includes(result, diagonal)
      refute_includes(result, far_diagonal)
      assert_includes(result, side)
      refute_includes(result, far_side)
    end
  end
end

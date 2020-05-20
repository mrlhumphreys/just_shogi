require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/ryuuma'

describe JustShogi::Ryuuma do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      ryuuma = JustShogi::Ryuuma.new(id: 1, player_number: 1)

      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: ryuuma) 
      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil) 
      far_forward = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: nil) 
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: nil) 
      far_diagonal = JustShogi::Square.new(id: '33', x: 6, y: 2, piece: nil) 
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: nil) 
      far_side = JustShogi::Square.new(id: '35', x: 6, y: 4, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, far_forward, diagonal, far_diagonal, side, far_side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ryuuma.destinations(from, game_state)

      assert_includes(result, forward)
      refute_includes(result, far_forward)
      assert_includes(result, diagonal)
      assert_includes(result, far_diagonal)
      assert_includes(result, side)
      refute_includes(result, far_side)
    end

    it 'returns the squares it can move to if occupied by opponent' do
      ryuuma = JustShogi::Ryuuma.new(id: 1, player_number: 1)

      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: ryuuma) 

      forward_piece = JustShogi::Ryuuma.new(id: 2, player_number: 2)
      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: forward_piece) 

      far_forward = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: nil) 

      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: nil) 

      far_diagonal_piece = JustShogi::Ryuuma.new(id: 3, player_number: 2)
      far_diagonal = JustShogi::Square.new(id: '33', x: 6, y: 2, piece: far_diagonal_piece) 

      side_piece = JustShogi::Ryuuma.new(id: 4, player_number: 2)
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: side_piece) 

      far_side = JustShogi::Square.new(id: '35', x: 6, y: 4, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, far_forward, diagonal, far_diagonal, side, far_side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ryuuma.destinations(from, game_state)

      assert_includes(result, forward)
      refute_includes(result, far_forward)
      assert_includes(result, diagonal)
      assert_includes(result, far_diagonal)
      assert_includes(result, side)
      refute_includes(result, far_side)
    end

    it 'does not return squares that are blocked' do
      ryuuma = JustShogi::Ryuuma.new(id: 1, player_number: 1)

      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: ryuuma) 

      forward_piece = JustShogi::Ryuuma.new(id: 2, player_number: 1)
      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: forward_piece) 

      far_forward = JustShogi::Square.new(id: '53', x: 4, y: 2, piece: nil) 

      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: nil) 

      far_diagonal_piece = JustShogi::Ryuuma.new(id: 3, player_number: 1)
      far_diagonal = JustShogi::Square.new(id: '33', x: 6, y: 2, piece: far_diagonal_piece) 

      side_piece = JustShogi::Ryuuma.new(id: 4, player_number: 1)
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: side_piece) 

      far_side = JustShogi::Square.new(id: '35', x: 6, y: 4, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, far_forward, diagonal, far_diagonal, side, far_side])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ryuuma.destinations(from, game_state)

      refute_includes(result, forward)
      refute_includes(result, far_forward)
      assert_includes(result, diagonal)
      refute_includes(result, far_diagonal)
      refute_includes(result, side)
      refute_includes(result, far_side)
    end
  end
end

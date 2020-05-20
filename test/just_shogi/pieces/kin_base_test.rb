require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/kin_base'

describe JustShogi::KinBase do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      kin_base = JustShogi::KinBase.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: kin_base) 
      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil) 
      diagonal_forward = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: nil) 
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: nil) 
      diagonal_backward = JustShogi::Square.new(id: '46', x: 5, y: 5, piece: nil) 
      backward = JustShogi::Square.new(id: '56', x: 4, y: 5, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, diagonal_forward, side, diagonal_backward, backward])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kin_base.destinations(from, game_state)

      assert_includes(result, forward)
      assert_includes(result, diagonal_forward)
      assert_includes(result, side)
      refute_includes(result, diagonal_backward)
      assert_includes(result, backward)
    end

    it 'returns the squares it can move to if occupied by opponent' do
      kin_base = JustShogi::KinBase.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: kin_base) 

      forward_piece = JustShogi::KinBase.new(id: 2, player_number: 2)
      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: forward_piece) 

      diagonal_forward_piece = JustShogi::KinBase.new(id: 3, player_number: 2)
      diagonal_forward = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_forward_piece) 

      side_piece = JustShogi::KinBase.new(id: 4, player_number: 2)
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: side_piece) 

      diagonal_backward_piece = JustShogi::KinBase.new(id: 5, player_number: 2)
      diagonal_backward = JustShogi::Square.new(id: '46', x: 5, y: 5, piece: diagonal_backward_piece) 

      backward_piece = JustShogi::KinBase.new(id: 6, player_number: 2)
      backward = JustShogi::Square.new(id: '56', x: 4, y: 5, piece: backward_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, diagonal_forward, side, diagonal_backward, backward])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kin_base.destinations(from, game_state)

      assert_includes(result, forward)
      assert_includes(result, diagonal_forward)
      assert_includes(result, side)
      refute_includes(result, diagonal_backward)
      assert_includes(result, backward)
    end

    it 'does not return squares it can move to if blocked' do
      kin_base = JustShogi::KinBase.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: kin_base) 

      forward_piece = JustShogi::KinBase.new(id: 2, player_number: 1)
      forward = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: forward_piece) 

      diagonal_forward_piece = JustShogi::KinBase.new(id: 3, player_number: 1)
      diagonal_forward = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_forward_piece) 

      side_piece = JustShogi::KinBase.new(id: 4, player_number: 1)
      side = JustShogi::Square.new(id: '45', x: 5, y: 4, piece: side_piece) 

      diagonal_backward_piece = JustShogi::KinBase.new(id: 5, player_number: 1)
      diagonal_backward = JustShogi::Square.new(id: '46', x: 5, y: 5, piece: diagonal_backward_piece) 

      backward_piece = JustShogi::KinBase.new(id: 6, player_number: 1)
      backward = JustShogi::Square.new(id: '56', x: 4, y: 5, piece: backward_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, forward, diagonal_forward, side, diagonal_backward, backward])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kin_base.destinations(from, game_state)

      refute_includes(result, forward)
      refute_includes(result, diagonal_forward)
      refute_includes(result, side)
      refute_includes(result, diagonal_backward)
      refute_includes(result, backward)
    end
  end
end

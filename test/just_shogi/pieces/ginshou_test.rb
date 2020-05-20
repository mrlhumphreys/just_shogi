require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/ginshou'

describe JustShogi::Ginshou do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      ginshou = JustShogi::Ginshou.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '78', x: 2, y: 7, piece: ginshou)
      forward = JustShogi::Square.new(id: '77', x: 2, y: 6, piece: nil)
      diagonal = JustShogi::Square.new(id: '67', x: 3, y: 6, piece: nil)
      sideways = JustShogi::Square.new(id: '68', x: 3, y: 7, piece: nil)
      backward = JustShogi::Square.new(id: '79', x: 2, y: 8, piece: nil)

      squares = JustShogi::SquareSet.new(squares: [from, forward, diagonal, sideways, backward])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ginshou.destinations(from, game_state)

      assert_includes(result, forward)
      assert_includes(result, diagonal)
      refute_includes(result, backward)
      refute_includes(result, sideways)
    end

    it 'does return the occupied by piece squares' do
      ginshou = JustShogi::Ginshou.new(id: 1, player_number: 1)
      piece_forward = JustShogi::Ginshou.new(id: 2, player_number: 2)
      piece_diagonal = JustShogi::Ginshou.new(id: 3, player_number: 2)
      piece_sideways = JustShogi::Ginshou.new(id: 4, player_number: 2)
      piece_backward = JustShogi::Ginshou.new(id: 5, player_number: 2)

      from = JustShogi::Square.new(id: '78', x: 2, y: 7, piece: ginshou)
      forward = JustShogi::Square.new(id: '77', x: 2, y: 6, piece: piece_forward)
      diagonal = JustShogi::Square.new(id: '67', x: 3, y: 6, piece: piece_diagonal)
      sideways = JustShogi::Square.new(id: '68', x: 3, y: 7, piece: piece_sideways)
      backward = JustShogi::Square.new(id: '79', x: 2, y: 8, piece: piece_backward)

      squares = JustShogi::SquareSet.new(squares: [from, forward, diagonal, sideways, backward])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ginshou.destinations(from, game_state)

      assert_includes(result, forward)
      assert_includes(result, diagonal)
      refute_includes(result, backward)
      refute_includes(result, sideways)
    end

    it 'does not return the blocked squares' do
      ginshou = JustShogi::Ginshou.new(id: 1, player_number: 1)
      piece_forward = JustShogi::Ginshou.new(id: 2, player_number: 1)
      piece_diagonal = JustShogi::Ginshou.new(id: 3, player_number: 1)
      piece_sideways = JustShogi::Ginshou.new(id: 4, player_number: 1)
      piece_backward = JustShogi::Ginshou.new(id: 5, player_number: 1)

      from = JustShogi::Square.new(id: '78', x: 2, y: 7, piece: ginshou)
      forward = JustShogi::Square.new(id: '77', x: 2, y: 6, piece: piece_forward)
      diagonal = JustShogi::Square.new(id: '67', x: 3, y: 6, piece: piece_diagonal)
      sideways = JustShogi::Square.new(id: '68', x: 3, y: 7, piece: piece_sideways)
      backward = JustShogi::Square.new(id: '79', x: 2, y: 8, piece: piece_backward)

      squares = JustShogi::SquareSet.new(squares: [from, forward, diagonal, sideways, backward])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = ginshou.destinations(from, game_state)

      refute_includes(result, forward)
      refute_includes(result, diagonal)
      refute_includes(result, backward)
      refute_includes(result, sideways)
    end
  end
end

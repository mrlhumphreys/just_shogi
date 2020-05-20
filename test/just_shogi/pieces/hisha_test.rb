require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/hisha'

describe JustShogi::Hisha do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      hisha = JustShogi::Hisha.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: hisha)
      orthogonal = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: nil)

      squares = JustShogi::SquareSet.new(squares: [from, orthogonal, diagonal])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = hisha.destinations(from, game_state)

      assert_includes(result, orthogonal)
      refute_includes(result, diagonal)
    end

    it 'returns the squares it can move to if occupied by opponent' do
      hisha = JustShogi::Hisha.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: hisha)
      orthogonal_piece = JustShogi::Hisha.new(id: 2, player_number: 2)
      diagonal_piece = JustShogi::Hisha.new(id: 3, player_number: 2)
      orthogonal = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: orthogonal_piece)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_piece)

      squares = JustShogi::SquareSet.new(squares: [from, orthogonal, diagonal])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = hisha.destinations(from, game_state)

      assert_includes(result, orthogonal)
      refute_includes(result, diagonal)
    end

    it 'does not return the squares that are blocked' do
      hisha = JustShogi::Hisha.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece: hisha)
      orthogonal_piece = JustShogi::Hisha.new(id: 2, player_number: 1)
      diagonal_piece = JustShogi::Hisha.new(id: 3, player_number: 1)
      orthogonal = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: orthogonal_piece)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_piece)

      squares = JustShogi::SquareSet.new(squares: [from, orthogonal, diagonal])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = hisha.destinations(from, game_state)

      refute_includes(result, orthogonal)
      refute_includes(result, diagonal)
    end
  end
end

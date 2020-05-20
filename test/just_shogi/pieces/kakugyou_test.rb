require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/kakugyou'

describe JustShogi::Kakugyou do
  describe '#destinations' do
    it 'returns the squares it can move to if unoccupied' do
      kakugyou = JustShogi::Kakugyou.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece:kakugyou) 
      orthogonal = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: nil)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: nil)

      squares = JustShogi::SquareSet.new(squares: [from, orthogonal, diagonal])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kakugyou.destinations(from, game_state)

      assert_includes(result, diagonal)
      refute_includes(result, orthogonal)
    end

    it 'returns the squares it can move to if occupied by opponent' do
      kakugyou = JustShogi::Kakugyou.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece:kakugyou) 
      orthogonal_piece = JustShogi::Kakugyou.new(id: 2, player_number: 2)
      diagonal_piece = JustShogi::Kakugyou.new(id: 3, player_number: 2)
      orthogonal = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: orthogonal_piece)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, orthogonal, diagonal])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kakugyou.destinations(from, game_state)

      assert_includes(result, diagonal)
      refute_includes(result, orthogonal)
    end

    it 'does not return blocked squares' do
      kakugyou = JustShogi::Kakugyou.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '55', x: 4, y: 4, piece:kakugyou) 
      orthogonal_piece = JustShogi::Kakugyou.new(id: 2, player_number: 1)
      diagonal_piece = JustShogi::Kakugyou.new(id: 3, player_number: 1)
      orthogonal = JustShogi::Square.new(id: '54', x: 4, y: 3, piece: orthogonal_piece)
      diagonal = JustShogi::Square.new(id: '44', x: 5, y: 3, piece: diagonal_piece) 

      squares = JustShogi::SquareSet.new(squares: [from, orthogonal, diagonal])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = kakugyou.destinations(from, game_state)

      refute_includes(result, diagonal)
      refute_includes(result, orthogonal)
    end
  end
end

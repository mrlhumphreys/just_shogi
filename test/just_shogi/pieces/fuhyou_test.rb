require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/fuhyou'
require 'just_shogi/square'
require 'just_shogi/square_set'
require 'just_shogi/game_state'

describe JustShogi::Fuhyou do
  describe '#destinations' do
    it 'returns the square in front if unoccupied' do
      fuhyou = JustShogi::Fuhyou.new(id: 1, player_number: 1)
      from = JustShogi::Square.new(id: '97', x: 0, y: 6, piece: fuhyou) 
      front = JustShogi::Square.new(id: '96', x: 0, y: 5, piece: nil) 
      diagonal = JustShogi::Square.new(id: '86', x: 1, y: 5, piece: nil) 
      side = JustShogi::Square.new(id: '87', x: 1, y: 6, piece: nil) 
      back = JustShogi::Square.new(id: '98', x: 0, y: 7, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, front, diagonal, side, back])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = fuhyou.destinations(from, game_state)

      assert_includes(result, front)
      refute_includes(result, diagonal)
      refute_includes(result, back)
      refute_includes(result, side)
    end

    it 'returns the square if the square is occupied by opponent' do
      fuhyou = JustShogi::Fuhyou.new(id: 1, player_number: 1)
      opponent = JustShogi::Fuhyou.new(id: 2, player_number: 2)
      from = JustShogi::Square.new(id: '97', x: 0, y: 6, piece: fuhyou) 
      front = JustShogi::Square.new(id: '96', x: 0, y: 5, piece: opponent) 
      diagonal = JustShogi::Square.new(id: '86', x: 1, y: 5, piece: nil) 
      side = JustShogi::Square.new(id: '87', x: 1, y: 6, piece: nil) 
      back = JustShogi::Square.new(id: '98', x: 0, y: 7, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, front, diagonal, side, back])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = fuhyou.destinations(from, game_state)

      assert_includes(result, front)
      refute_includes(result, diagonal)
      refute_includes(result, back)
      refute_includes(result, side)
    end

    it 'does not return the square in front blocked' do
      fuhyou = JustShogi::Fuhyou.new(id: 1, player_number: 1)
      block = JustShogi::Fuhyou.new(id: 2, player_number: 1)
      from = JustShogi::Square.new(id: '97', x: 0, y: 6, piece: fuhyou) 
      front = JustShogi::Square.new(id: '96', x: 0, y: 5, piece: block) 
      diagonal = JustShogi::Square.new(id: '86', x: 1, y: 5, piece: nil) 
      side = JustShogi::Square.new(id: '87', x: 1, y: 6, piece: nil) 
      back = JustShogi::Square.new(id: '98', x: 0, y: 7, piece: nil) 

      squares = JustShogi::SquareSet.new(squares: [from, front, diagonal, side, back])

      game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

      result = fuhyou.destinations(from, game_state)

      refute_includes(result, front)
      refute_includes(result, diagonal)
      refute_includes(result, back)
      refute_includes(result, side)
    end
  end
end

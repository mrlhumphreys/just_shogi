require 'just_shogi/pieces/piece'

module JustShogi

  # = Hisha
  #
  # The piece that moves any number of squares orthogonally.
  class Hisha < Piece
    
    # All the squares that the piece can move to and/or capture.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def destinations(square, game_state)
      game_state.squares.orthogonal(square).unoccupied_or_occupied_by_opponent(player_number).unblocked(square, game_state.squares)
    end
  end
end

require 'just_shogi/pieces/piece'

module JustShogi

  # = Ryuuma 
  #
  # The piece that moves diagonally any number of squares and 1 space orthogonally
  class Ryuuma < Piece

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
      (game_state.squares.diagonal(square) | game_state.squares.at_range(square, 1)).unoccupied_or_occupied_by_opponent(player_number).unblocked(square, game_state.squares)
    end
  end
end

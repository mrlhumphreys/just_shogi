require 'just_shogi/pieces/piece'

module JustShogi

  # = Fuhyou
  #
  # The piece that moves forward one space.
  class Fuhyou < Piece

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
      game_state.squares.in_range(square, 1).in_direction(square, forwards_direction).orthogonal(square).unoccupied_or_occupied_by_opponent(player_number).unblocked(square, game_state.squares)
    end
  end
end

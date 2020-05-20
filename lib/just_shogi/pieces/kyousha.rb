require 'just_shogi/pieces/piece'

module JustShogi

  # = Kyousha
  #
  # The piece that moves forward any number of spaces.
  class Kyousha < Piece

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
      game_state.squares.orthogonal(square).in_direction(square, forwards_direction).unoccupied_or_occupied_by_opponent(player_number).unblocked(square, game_state.squares)
    end
  end
end

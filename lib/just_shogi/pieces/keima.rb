require 'just_shogi/pieces/piece'

module JustShogi

  # = Keima
  #
  # The piece that jumps over pieces 2v1h forwards.
  class Keima < Piece
  
    # All the suares that the piece can move to and/or capture.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def destinations(square, game_state)
      game_state.squares.in_direction(square, forwards_direction).ranks_away(square, 2).files_away(square, 1).unoccupied_or_occupied_by_opponent(player_number)
    end
  end
end

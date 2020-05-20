require 'just_shogi/pieces/piece'

module JustShogi

  # = Ou Base 
  #
  # The piece that moves 1 space away.
  class OuBase < Piece

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
      base_destinations(square, game_state) # - checked_squares(square, game_state) - shared_king_squares(game_state)
    end

    # All the squares that the king could move to normally.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def base_destinations(square, game_state)
      game_state.squares.at_range(square, 1).unoccupied_or_occupied_by_opponent(player_number)
    end

    # All the squares that the king could not move to because of check.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def checked_squares(square, game_state)
      dup = game_state.clone
      # set the piece to nil to handle case where a piece threatens squares behind this piece.
      dup.squares.find_ou_for_player(player_number).piece = nil
      dup.squares.threatened_by(opponent, dup)
    end

    # All the squares that the king could not move to because antoher king is nearby.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def shared_king_squares(game_state)
      all = game_state.squares.occupied_by_piece(JustShogi::OuBase).map { |s| s.piece.base_destinations(s, game_state) }

      all.reduce(nil) do |memo, set|
        if memo
          memo & set
        else
          set
        end
      end
    end
  end
end

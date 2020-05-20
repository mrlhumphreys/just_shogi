require 'just_shogi/square'
require 'board_game_grid'

module JustShogi
  
  # = Square Set
  #
  # A collection of Squares with useful filtering functions
  class SquareSet < BoardGameGrid::SquareSet

    # New objects can be instantiated by passing in a hash with squares.
    # They can be square objects or hashes.
    #
    # @param [Array<Square,Hash>] squares
    #   An array of squares, each with an x and y co-oordinates an a piece.
    #
    # ==== Example:
    #   # Instantiates a new Square Sete
    #   JustShogi::SquareSet.new({
    #     squares: [
    #       { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 1, type: 'fuhyou' } }
    #     ]
    #   })
    def initialize(squares: )
      @squares = if squares.all? { |s| s.instance_of?(Hash) }
                   squares.map { |s| Square.new(**s) } 
                 elsif squares.all? { |s| s.instance_of?(Square) }
                   squares
                 else
                   raise ArgumentError, "all squares must have the same class"
                 end
    end

    # Find the square occupied by the player's king
    #
    # @param [Fixnum] player_number
    #   the number of the player
    #
    # @return [Square]
    # ==== Example:
    #   # Find the square occupied by player 2's ou
    #   square_est.find_ou_for_player(2)
    def find_ou_for_player(player_number)
      find { |s| s.piece && s.piece.is_a?(JustShogi::OuBase) && s.occupied_by_player?(player_number) }
    end

    # Returns all squares threatened by the specified player
    #
    # @param [Fixnum] player_number
    #   the player's number.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def threatened_by(player_number, game_state)
      _squares = occupied_by_player(player_number).map do |s|
        s.piece.potential_capture_squares(s, game_state).squares
      end.flatten.uniq

      self.class.new(squares: _squares)
    end
  end
end

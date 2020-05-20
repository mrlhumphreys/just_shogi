require 'just_shogi/pieces/fuhyou'
require 'just_shogi/pieces/kakugyou'
require 'just_shogi/pieces/hisha'
require 'just_shogi/pieces/kyousha'
require 'just_shogi/pieces/keima'
require 'just_shogi/pieces/ginshou'
require 'just_shogi/pieces/kinshou'
require 'just_shogi/pieces/oushou'
require 'just_shogi/pieces/gyokushou'

require 'just_shogi/pieces/tokin'
require 'just_shogi/pieces/narikyou'
require 'just_shogi/pieces/narikei'
require 'just_shogi/pieces/narigin'
require 'just_shogi/pieces/ryuuma'
require 'just_shogi/pieces/ryuuou'

module JustShogi

  # = Promotion Factory
  #
  # Generates the promoted or demoted piece given a piece
  class PromotionFactory
    
    # A mapping of promotions
    PROMOTIONS = {
      Fuhyou => Tokin,
      Kakugyou => Ryuuma,
      Hisha => Ryuuou,
      Kyousha => Narikyou,
      Keima => Narikei,
      Ginshou => Narigin
    }

    # New objects can be instantiated by passing in the piece
    #
    # @params [Piece] piece
    #   the piece to be promoted
    def initialize(piece)
      @piece = piece
    end

    def promotable?
      !PROMOTIONS[@piece.class].nil?
    end

    def demotable?
      !PROMOTIONS.key(@piece.class).nil?
    end

    # Returns the promoted piece
    def promote
      promoted_klass = PROMOTIONS[@piece.class]
      if promoted_klass 
        promoted_klass.new(id: @piece.id, player_number: @piece.player_number)
      else
        raise ArgumentError, "Piece cannot be promoted."
      end
    end

    # Returns the demoted piece
    def demote
      demoted_klass = PROMOTIONS.key(@piece.class)
      if demoted_klass 
        demoted_klass.new(id: @piece.id, player_number: @piece.player_number)
      else
        raise ArgumentError, "Piece cannot be demoted."
      end
    end
  end
end

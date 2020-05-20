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

  # = Piece Factory
  #
  # Generates pieces from a hash of arguments
  class PieceFactory

    # A mapping of type descriptions to classes.
    CLASSES = {
      'fuhyou' => Fuhyou,
      'kakugyou' => Kakugyou,
      'hisha' => Hisha,
      'kyousha' => Kyousha,
      'keima' => Keima,
      'ginshou' => Ginshou,
      'kinshou' => Kinshou,
      'oushou' => Oushou,
      'gyokushou' => Gyokushou,
      'tokin' => Tokin,
      'narikyou' => Narikyou,
      'narikei' => Narikei,
      'narigin' => Narigin,
      'ryuuma' => Ryuuma,
      'ryuuou' => Ryuuou
    }

    # New objects can be instantiated by passing in a hash or the piece.
    #
    # @param [Hash,Piece] args
    #   the initial attributes of the piece, hash requires type key
    #
    # ==== Example:
    #   # Instantiates a new PieceFactory
    #   JustShogi::PieceFactory.new({
    #     type: 'fuhyou',
    #     id: 1,
    #     player_number: 2
    #   })
    def initialize(args)
      @args = args
    end

    # Returns a piece based on the initial arguments.
    #
    # @return [Piece]
    def build
      case @args
      when Hash
        build_from_hash
      when Piece
        @args
      when nil
        nil
      else
        raise ArgumentError, "piece must be Hash or NilClass"
      end
    end

    private

    def build_from_hash
      klass = CLASSES[@args[:type]]
      if klass
        klass.new(**@args)
      else
        raise ArgumentError, "invalid piece type: #{@args[:type].to_s}"
      end
    end
  end
end

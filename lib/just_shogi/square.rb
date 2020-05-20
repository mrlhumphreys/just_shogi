require 'just_shogi/piece_factory'
require 'board_game_grid'

module JustShogi

  # = Square
  #
  # A Square on a shogi board.
  class Square < BoardGameGrid::Square

    # New object can be instantiated by passing in a hash with
    #
    # @param [String] id
    #   the unique identifier of the square.
    #
    # @param [Fixnum] x
    #   the x co-ordinate of the square.
    #
    # @param [Fixnum] y
    #   the y co-ordinate of the square.
    #
    # @option [Piece,Hash,NilClass] piece
    #   The piece on the square, can be a piece object or hash or nil.
    #
    # ==== Example:
    #   # Instantiates a new Square
    #   JustShogi::Square.new({
    #     id: '91',
    #     x: 0,
    #     y: 0,
    #     piece: { id: 1, player_number: 1, type: 'fuhyou' }
    #   })
    def initialize(id: , x: , y: , piece: nil)
      @id = id
      @x = x
      @y = y
      @piece = PieceFactory.new(piece).build
    end

    def promotion_zone(player_number)
      case player_number
      when 1
        (0..2).include?(y)
      when 2
        (6..8).include?(y)
      else
        raise ArgumentError, "Invalid Player Number"
      end
    end
  end
end

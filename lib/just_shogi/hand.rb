require 'just_shogi/piece_factory'
require 'just_shogi/promotion_factory'
require 'just_shogi/pieces/piece'

module JustShogi
  class Hand
    def initialize(player_number: , pieces: [])
      @player_number = player_number
      @pieces = if pieces.instance_of?(Array)
                  if pieces.all? { |p| p.is_a?(Hash) }
                    pieces.map { |p| JustShogi::PieceFactory.new(p).build }
                  elsif pieces.all? { |p| p.is_a?(JustShogi::Piece) }
                    pieces
                  else
                    raise ArgumentError, "all pieces must have the same class"
                  end
                else
                  raise ArgumentError, "pieces must be an array"
                end
    end

    attr_reader :player_number
    attr_reader :pieces

    def push_piece(piece)
      factory = PromotionFactory.new(piece)
      demoted_piece = factory.demotable? ? factory.demote : piece
      demoted_piece.switch_player
      @pieces.push(demoted_piece)
    end

    def pop_piece(id)
      p = find_piece_by_id(id) 
      @pieces.delete(p)
    end

    def find_piece_by_id(id)
      pieces.find { |p| p.id == id } 
    end

    def as_json
      {
        player_number: player_number,
        pieces: pieces.map(&:as_json) 
      }
    end
  end
end

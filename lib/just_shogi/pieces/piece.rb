require 'board_game_grid' 

module JustShogi

  # = Piece
  #
  # A piece that can move on a chess board
  class Piece < BoardGameGrid::Piece
    def initialize(id: , player_number: , type: nil)
      @id = id
      @player_number = player_number
    end

    def switch_player
      @player_number = opponent
    end

    def has_legal_moves_from_y(_)
      true 
    end
  end
end

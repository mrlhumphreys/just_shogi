require 'just_shogi/errors/no_piece_error'
require 'just_shogi/errors/not_players_turn_error'
require 'just_shogi/errors/off_board_error'
require 'just_shogi/errors/invalid_move_error'
require 'just_shogi/errors/moved_into_check_error'
require 'just_shogi/errors/invalid_promotion_error'
require 'just_shogi/errors/piece_not_found_error'
require 'just_shogi/errors/square_occupied_error'
require 'just_shogi/errors/no_legal_moves_error'
require 'just_shogi/errors/two_fuhyou_in_file_error'
require 'just_shogi/errors/dropped_into_check_error'
require 'just_shogi/square_set'
require 'just_shogi/hand'
require 'just_shogi/promotion_factory'
require 'just_shogi/pieces/fuhyou'

module JustShogi

  # = Game State
  #
  # Represents a game of Shogi in progress.
  class GameState
    def initialize(current_player_number: , squares: [], hands: [])
      @current_player_number = current_player_number
      @squares = if squares.is_a?(SquareSet)
                   squares
                 else
                   SquareSet.new(squares: squares)
                 end
      @hands = if hands.is_a?(Array)
                if hands.all? { |hand| hand.is_a?(Hand) }
                  hands
                elsif hands.all? { |hand| hand.is_a?(Hash) }
                  hands.map { |hand| Hand.new(**hand) }
                else
                  raise ArgumentError, "hands must all be the same class"
                end
               else
                 raise ArgumentError, "hands must be an array"
               end
    end

    attr_reader :current_player_number, :squares, :hands, :errors

    # Instantiates a new GameState object in the starting position.
    #
    # @return [GameState]
    def self.default
      new(
        current_player_number: 1,
        squares: [
          { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'kyousha' } },
          { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'keima' } },
          { id: '71', x: 2, y: 0, piece: { id: 3, player_number: 2, type: 'ginshou' } },
          { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 2, type: 'kinshou' } },
          { id: '51', x: 4, y: 0, piece: { id: 5, player_number: 2, type: 'oushou' } },
          { id: '41', x: 5, y: 0, piece: { id: 6, player_number: 2, type: 'kinshou' } },
          { id: '31', x: 6, y: 0, piece: { id: 7, player_number: 2, type: 'ginshou' } },
          { id: '21', x: 7, y: 0, piece: { id: 8, player_number: 2, type: 'keima' } },
          { id: '11', x: 8, y: 0, piece: { id: 9, player_number: 2, type: 'kyousha' } },

          { id: '92', x: 0, y: 1, piece: nil },
          { id: '82', x: 1, y: 1, piece: { id: 10, player_number: 2, type: 'hisha' } },
          { id: '72', x: 2, y: 1, piece: nil },
          { id: '62', x: 3, y: 1, piece: nil },
          { id: '52', x: 4, y: 1, piece: nil },
          { id: '42', x: 5, y: 1, piece: nil },
          { id: '32', x: 6, y: 1, piece: nil },
          { id: '22', x: 7, y: 1, piece: { id: 11, player_number: 2, type: 'kakugyou' } },
          { id: '12', x: 8, y: 1, piece: nil },

          { id: '93', x: 0, y: 2, piece: { id: 12, player_number: 2, type: 'fuhyou' } },
          { id: '83', x: 1, y: 2, piece: { id: 13, player_number: 2, type: 'fuhyou' } },
          { id: '73', x: 2, y: 2, piece: { id: 14, player_number: 2, type: 'fuhyou' } },
          { id: '63', x: 3, y: 2, piece: { id: 15, player_number: 2, type: 'fuhyou' } },
          { id: '53', x: 4, y: 2, piece: { id: 16, player_number: 2, type: 'fuhyou' } },
          { id: '43', x: 5, y: 2, piece: { id: 17, player_number: 2, type: 'fuhyou' } },
          { id: '33', x: 6, y: 2, piece: { id: 18, player_number: 2, type: 'fuhyou' } },
          { id: '23', x: 7, y: 2, piece: { id: 19, player_number: 2, type: 'fuhyou' } },
          { id: '13', x: 8, y: 2, piece: { id: 20, player_number: 2, type: 'fuhyou' } },

          { id: '94', x: 0, y: 3, piece: nil },
          { id: '84', x: 1, y: 3, piece: nil },
          { id: '74', x: 2, y: 3, piece: nil },
          { id: '64', x: 3, y: 3, piece: nil },
          { id: '54', x: 4, y: 3, piece: nil },
          { id: '44', x: 5, y: 3, piece: nil },
          { id: '34', x: 6, y: 3, piece: nil },
          { id: '24', x: 7, y: 3, piece: nil },
          { id: '14', x: 8, y: 3, piece: nil },

          { id: '95', x: 0, y: 4, piece: nil },
          { id: '85', x: 1, y: 4, piece: nil },
          { id: '75', x: 2, y: 4, piece: nil },
          { id: '65', x: 3, y: 4, piece: nil },
          { id: '55', x: 4, y: 4, piece: nil },
          { id: '45', x: 5, y: 4, piece: nil },
          { id: '35', x: 6, y: 4, piece: nil },
          { id: '25', x: 7, y: 4, piece: nil },
          { id: '15', x: 8, y: 4, piece: nil },

          { id: '96', x: 0, y: 5, piece: nil },
          { id: '86', x: 1, y: 5, piece: nil },
          { id: '76', x: 2, y: 5, piece: nil },
          { id: '66', x: 3, y: 5, piece: nil },
          { id: '56', x: 4, y: 5, piece: nil },
          { id: '46', x: 5, y: 5, piece: nil },
          { id: '36', x: 6, y: 5, piece: nil },
          { id: '26', x: 7, y: 5, piece: nil },
          { id: '16', x: 8, y: 5, piece: nil },

          { id: '97', x: 0, y: 6, piece: { id: 21, player_number: 1, type: 'fuhyou' } },
          { id: '87', x: 1, y: 6, piece: { id: 22, player_number: 1, type: 'fuhyou' } },
          { id: '77', x: 2, y: 6, piece: { id: 23, player_number: 1, type: 'fuhyou' } },
          { id: '67', x: 3, y: 6, piece: { id: 24, player_number: 1, type: 'fuhyou' } },
          { id: '57', x: 4, y: 6, piece: { id: 25, player_number: 1, type: 'fuhyou' } },
          { id: '47', x: 5, y: 6, piece: { id: 26, player_number: 1, type: 'fuhyou' } },
          { id: '37', x: 6, y: 6, piece: { id: 27, player_number: 1, type: 'fuhyou' } },
          { id: '27', x: 7, y: 6, piece: { id: 28, player_number: 1, type: 'fuhyou' } },
          { id: '17', x: 8, y: 6, piece: { id: 29, player_number: 1, type: 'fuhyou' } },

          { id: '98', x: 0, y: 7, piece: nil },
          { id: '88', x: 1, y: 7, piece: { id: 30, player_number: 1, type: 'kakugyou' } },
          { id: '78', x: 2, y: 7, piece: nil },
          { id: '68', x: 3, y: 7, piece: nil },
          { id: '58', x: 4, y: 7, piece: nil },
          { id: '48', x: 5, y: 7, piece: nil },
          { id: '38', x: 6, y: 7, piece: nil },
          { id: '28', x: 7, y: 7, piece: { id: 31, player_number: 1, type: 'hisha' } },
          { id: '18', x: 8, y: 7, piece: nil },

          { id: '99', x: 0, y: 8, piece: { id: 32, player_number: 1, type: 'kyousha' } },
          { id: '89', x: 1, y: 8, piece: { id: 33, player_number: 1, type: 'keima' } },
          { id: '79', x: 2, y: 8, piece: { id: 34, player_number: 1, type: 'ginshou' } },
          { id: '69', x: 3, y: 8, piece: { id: 35, player_number: 1, type: 'kinshou' } },
          { id: '59', x: 4, y: 8, piece: { id: 36, player_number: 1, type: 'gyokushou' } },
          { id: '49', x: 5, y: 8, piece: { id: 37, player_number: 1, type: 'kinshou' } },
          { id: '39', x: 6, y: 8, piece: { id: 38, player_number: 1, type: 'ginshou' } },
          { id: '29', x: 7, y: 8, piece: { id: 39, player_number: 1, type: 'keima' } },
          { id: '19', x: 8, y: 8, piece: { id: 40, player_number: 1, type: 'kyousha' } }
        ],
        hands: [
          { player_number: 1, pieces: [] },
          { player_number: 2, pieces: [] },
        ]
      )
    end

    # serializes the game state as ahash
    #
    # @return [Hash]
    def as_json
      {
        current_player_number: current_player_number,
        squares: squares.as_json,
        hands: hands.map(&:as_json)
      }
    end

    # deep clone of the game state
    #
    # @return [GameState]
    def clone
      self.class.new(**as_json)
    end

    # Moves a piece owned by the player, from one square, to another. 
    #
    # It has an option to promote the moving piece.
    # It moves the piece and returns true if the move is valid and it's the player's turn.
    # It returns false otherwise.
    #
    # ==== Example:
    #   # Moves a piece from a square to perform a move
    #   game_state.move(1, '77', '78')
    #
    # @param [Fixnum] player_number
    #   the player number, 1 or 2.
    #
    # @param [String] from_id
    #   the id of the from square
    #
    # @param [String] to_id
    #   the id of the to square
    #
    # @param [boolean] promote
    #
    # @return [Boolean]
    def move(player_number, from_id, to_id, promote = false)
      @errors = []

      from = squares.find_by_id(from_id)
      to = squares.find_by_id(to_id)

      if current_player_number != player_number
        @errors.push JustShogi::NotPlayersTurnError.new
      elsif from.unoccupied?
        @errors.push JustShogi::NoPieceError.new
      elsif to.nil? 
        @errors.push JustShogi::OffBoardError.new
      elsif promote && !promotable?(player_number, from, to) 
        @errors.push JustShogi::InvalidPromotionError.new
      elsif from.piece.can_move?(from, to, self) 
        
        duplicate = self.clone
        duplicate.perform_complete_move(player_number, from_id, to_id, promote)

        if duplicate.in_check?(current_player_number)
          @errors.push JustShogi::MovedIntoCheckError.new
        else
          perform_complete_move(player_number, from_id, to_id, promote)
        end
      else
        @errors.push JustShogi::InvalidMoveError.new
      end

      @errors.empty?
    end

    def drop(player_number, piece_id, square_id)
      @errors = []
  
      piece = hand_for_player(player_number).find_piece_by_id(piece_id)
      square = squares.find_by_id(square_id)

      if current_player_number != player_number
        @errors.push JustShogi::NotPlayersTurnError.new
      elsif piece.nil? 
        @errors.push JustShogi::PieceNotFoundError.new
      elsif square.nil?
        @errors.push JustShogi::OffBoardError.new
      elsif square.occupied?
        @errors.push JustShogi::SquareOccupiedError.new
      elsif !piece.has_legal_moves_from_y(square.y)
        @errors.push JustShogi::NoLegalMovesError.new
      elsif squares.where(x: square.x).occupied_by_piece(JustShogi::Fuhyou).occupied_by_player(player_number).any?
        @errors.push JustShogi::TwoFuhyouInFileError.new
      else
        duplicate = self.clone
        duplicate.perform_complete_drop(player_number, piece_id, square_id)

        if duplicate.in_check?(opposing_player_number)
          @errors.push JustShogi::DroppedIntoCheckError.new
        else
          perform_complete_drop(player_number, piece_id, square_id)
        end
      end

      @errors.empty?
    end

    # The player number of the winner. It returns nil if there is no winner.
    #
    # @return [Fixnum,NilClass]
    def winner
      case
      when in_checkmate?(1)
        2
      when in_checkmate?(2)
        1
      else
        nil
      end
    end

    # Moves a piece owned by the player, from one square, to another, with the option to promote. 
    #
    # It moves the piece and returns true if the move is valid and it's the player's turn.
    # It returns false otherwise.
    # It promotes if possible and specified.
    #
    def perform_complete_move(player_number, from_id, to_id, promote = false)
      from = squares.find_by_id(from_id)
      to = squares.find_by_id(to_id)

      captured = to.occupied? ? to : nil

      @last_change = { type: 'move', data: { player_number: player_number, from: from_id, to: to_id } }

      perform_move(player_number, from, to, captured)

      promote_piece(to) if promote
      pass_turn
    end

    def perform_complete_drop(player_number, piece_id, square_id)
      hand = hand_for_player(player_number)
      square = squares.find_by_id(square_id)

      @last_change = { type: 'drop', data: { player_number: player_number, piece: piece_id, square: square_id } }

      piece = hand.pop_piece(piece_id)
      square.piece = piece

      pass_turn
    end

    def in_check?(player_number)
      ou_square = squares.find_ou_for_player(player_number)
      threatened_by = squares.threatened_by(opposing_player_number(player_number), self)
      threatened_by.include?(ou_square)
    end

    def in_checkmate?(player_number)
      (in_check?(player_number) || non_ou_pieces_cannot_move?(player_number)) && ou_cannot_move?(player_number)
    end

    private

    def non_ou_pieces_cannot_move?(player_number)
      squares.occupied_by_player(player_number).excluding_piece(JustShogi::OuBase).all? { |s| s.piece.destinations(s, self).empty? }
    end

    def ou_cannot_move?(player_number)
      ou_square = squares.find_ou_for_player(player_number)
      destinations = ou_square.piece.destinations(ou_square, self)
      destinations.all? do |destination|
        duplicate = self.clone
        duplicate.perform_complete_move(player_number, ou_square.id, destination.id)
        duplicate.in_check?(player_number)
      end
    end

    def pass_turn
      @current_player_number = opposing_player_number
    end

    def opposing_player_number(player_number = nil)
      if player_number
        other_player_number(player_number)
      else
        other_player_number(@current_player_number) 
      end
    end

    def other_player_number(player_number)
      (player_number == 1) ? 2 : 1 
    end

    def hand_for_player(player_number)
      hands.find { |h| h.player_number == player_number }
    end

    def perform_move(player_number, from, to, captured)
      if captured
        hand_for_player(player_number).push_piece(to.piece)
        captured.piece = nil
      end
      to.piece = from.piece
      from.piece = nil
    end

    def promotable?(player_number, from, to)
      PromotionFactory.new(from.piece).promotable? && to.promotion_zone(player_number)
    end

    def promote_piece(square)
      new_piece = PromotionFactory.new(square.piece).promote
      square.piece = new_piece
    end
  end
end

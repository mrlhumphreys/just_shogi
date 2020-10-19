require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/game_state'

describe JustShogi::GameState do
  describe '#initialize' do
    describe 'given a square set for squares' do
      it 'sets the square set' do
        square_set = JustShogi::SquareSet.new(squares: [
          { id: '55', x: 4, y: 4, piece: nil },
          { id: '45', x: 5, y: 4, piece: nil }
        ])
        game_state = JustShogi::GameState.new(current_player_number: 1, squares: square_set)

        assert_equal square_set, game_state.squares
      end
    end

    describe 'given an array for squares' do
      it 'sets the square set' do
        squares = [
          { id: '55', x: 4, y: 4, piece: nil },
          { id: '45', x: 5, y: 4, piece: nil }
        ]
        game_state = JustShogi::GameState.new(current_player_number: 1, squares: squares)

        assert_instance_of JustShogi::SquareSet, game_state.squares
        assert_equal 2, game_state.squares.size
      end
    end

    describe 'given hashes for hands' do
      it 'sets the hands' do
        hands = [
          { player_number: 1, pieces: [] },
          { player_number: 2, pieces: [] },
        ]
        game_state = JustShogi::GameState.new(current_player_number: 1, squares: [], hands: hands)
        assert_instance_of JustShogi::Hand, game_state.hands.first
        assert_equal 2, game_state.hands.size
      end
    end

    describe 'given hands for hands' do
      it 'sets the hands' do
        hands = [
          JustShogi::Hand.new(player_number: 1, pieces: []),
          JustShogi::Hand.new(player_number: 2, pieces: []),
        ]
        game_state = JustShogi::GameState.new(current_player_number: 1, squares: [], hands: hands)
        assert_instance_of JustShogi::Hand, game_state.hands.first
        assert_equal 2, game_state.hands.size
      end
    end

    describe 'given a mix for hands' do
      it 'raises an error' do
        hands = [
          { player_number: 1, pieces: [] },
          JustShogi::Hand.new(player_number: 2, pieces: []),
        ]

        assert_raises(ArgumentError) do
          JustShogi::GameState.new(current_player_number: 1, squares: [], hands: hands)
        end
      end
    end

    describe 'given a non array for hands' do
      it 'raises an error' do
        hands = 'array of hands'

        assert_raises(ArgumentError) do
          JustShogi::GameState.new(current_player_number: 1, squares: [], hands: hands)
        end
      end
    end
  end

  describe '.default' do
    it 'returns the right sized board' do
      game_state = JustShogi::GameState.default

      assert_equal 81, game_state.squares.size
      assert_equal 40, game_state.squares.select(&:piece).size
    end
  end

  describe '#as_json' do
    it 'returns a serialized representation of the game state' do
      game_state = JustShogi::GameState.default
      expected = {
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
          { player_number: 2, pieces: [] }
        ]
      }

      result = game_state.as_json

      assert_equal expected, result
    end
  end

  describe '.clone' do
    it 'returns a deep clone of the game state' do
      game_state = JustShogi::GameState.default
      result = game_state.clone

      refute_equal game_state.object_id, result.object_id
      assert_equal game_state.as_json, result.as_json
    end
  end

  describe '#move' do
    describe 'not players turn' do
      it 'should not change the board' do
        game_state = JustShogi::GameState.default 
        from_id = '83'
        to_id = '84'

        result = game_state.move(2, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)
        
        refute result
        assert game_state.errors.any? { |e| e.is_a?(JustShogi::NotPlayersTurnError) }
        refute_nil from.piece
        assert_nil to.piece
      end
    end

    describe 'no piece to move' do
      it 'should not change the board' do
        game_state = JustShogi::GameState.default 
        from_id = '96'
        to_id = '95'

        result = game_state.move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        refute result
        assert game_state.errors.any? { |e| e.is_a?(JustShogi::NoPieceError) }
        assert_nil from.piece
        assert_nil to.piece
      end
    end

    describe 'moving to off the board' do
      it 'should not change the board' do
        game_state = JustShogi::GameState.default 
        from_id = '97'
        to_id = '107'

        result = game_state.move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        refute result
        assert game_state.errors.any? { |e| e.is_a?(JustShogi::OffBoardError) }
        refute_nil from.piece
        assert_nil to
      end
    end

    describe 'piece cannot move' do
      it 'should not change the board' do
        game_state = JustShogi::GameState.default 
        from_id = '97'
        to_id = '95'

        result = game_state.move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        refute result
        assert game_state.errors.any? { |e| e.is_a?(JustShogi::InvalidMoveError) }
        refute_nil from.piece
        assert_nil to.piece
      end
    end

    describe 'move results in check' do
      it 'should not change the board' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
          { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
          { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
          { id: '71', x: 2, y: 0, piece: { id: 3, player_number: 1, type: 'hisha' } },
          { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

          { id: '72', x: 2, y: 1, piece: nil },
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )
        from_id = '71'
        to_id = '72'

        result = game_state.move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        refute result
        assert game_state.errors.any? { |e| e.is_a?(JustShogi::MovedIntoCheckError) }
        refute_nil from.piece
        assert_nil to.piece
      end
    end

    describe 'move is valid' do
      it 'should change the board' do
        game_state = JustShogi::GameState.default 
        from_id = '97'
        to_id = '96'

        result = game_state.move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        assert result
        assert game_state.errors.empty?
        assert_nil from.piece
        refute_nil to.piece
      end
    end

    describe 'invalid promotion - piece is not in promotion zone' do
      it 'should not change the board' do
        game_state = JustShogi::GameState.default 
        from_id = '97'
        to_id = '96'
        promote = true

        result = game_state.move(1, from_id, to_id, promote)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        refute result
        assert game_state.errors.any? { |e| e.is_a?(JustShogi::InvalidPromotionError) }
        refute_nil from.piece
        assert_nil to.piece
      end
    end

    describe 'invalid promotion - piece is not promotable' do
      it 'should not change the board' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '72', x: 2, y: 1, piece: { id: 1, player_number: 1, type: 'tokin' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )
        from_id = '72'
        to_id = '71'
        promote = true

        result = game_state.move(1, from_id, to_id, promote)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        refute result
        assert game_state.errors.any? { |e| e.is_a?(JustShogi::InvalidPromotionError) }
        refute_nil from.piece
        assert_nil to.piece
      end
    end

    describe 'valid promotion' do
      it 'should change the board' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '72', x: 2, y: 1, piece: { id: 1, player_number: 1, type: 'fuhyou' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )
        from_id = '72'
        to_id = '71'
        promote = true

        result = game_state.move(1, from_id, to_id, promote)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        assert result
        assert game_state.errors.empty?
        assert_nil from.piece
        refute_nil to.piece
        assert_instance_of JustShogi::Tokin, to.piece
      end
    end

    describe 'valid capture' do
      it 'should change the board' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '82', x: 1, y: 1, piece: { id: 1, player_number: 1, type: 'fuhyou' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )
        from_id = '82'
        to_id = '81'

        result = game_state.move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)
        hand = game_state.hands.find { |h| h.player_number == 1 }

        assert result
        assert game_state.errors.empty?
        assert_nil from.piece
        refute_nil to.piece
        assert_instance_of JustShogi::Fuhyou, to.piece
        assert_equal 1, hand.pieces.size
        assert_instance_of JustShogi::Hisha, hand.pieces.first
      end
    end

    describe 'valid capture - promoted piece' do
      it 'should change the board' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'ryuuou' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '82', x: 1, y: 1, piece: { id: 1, player_number: 1, type: 'fuhyou' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )
        from_id = '82'
        to_id = '81'

        result = game_state.move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)
        hand = game_state.hands.find { |h| h.player_number == 1 }

        assert result
        assert game_state.errors.empty?
        assert_nil from.piece
        refute_nil to.piece
        assert_instance_of JustShogi::Fuhyou, to.piece
        assert_equal 1, hand.pieces.size
        assert_instance_of JustShogi::Hisha, hand.pieces.first
      end
    end
  end

  describe '#drop' do
    describe 'when valid' do
      it 'changes the board state' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'fuhyou' } ] },
            { player_number: 2, pieces: [] }
          ]
        )
        player_number = 1
        piece_id = 5
        square_id = '62'

        result = game_state.drop(player_number, piece_id, square_id)

        hand = game_state.hands.find { |h| h.player_number == player_number }
        square = game_state.squares.find_by_id(square_id)

        assert result
        assert game_state.errors.empty?
        assert_equal 0, hand.pieces.size
        assert_instance_of JustShogi::Fuhyou, square.piece
        assert_equal 2, game_state.current_player_number
      end
    end

    describe 'when not on turn' do
      it 'does not change the board state' do
        game_state = JustShogi::GameState.new(
          current_player_number: 2,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'fuhyou' } ] },
            { player_number: 2, pieces: [] }
          ]
        )
        player_number = 1
        piece_id = 5
        square_id = '62'

        result = game_state.drop(player_number, piece_id, square_id)

        hand = game_state.hands.find { |h| h.player_number == player_number }
        square = game_state.squares.find_by_id(square_id)

        refute result
        assert game_state.errors.find { |e| e.is_a?(JustShogi::NotPlayersTurnError) }
        assert_equal 1, hand.pieces.size
        assert_nil square.piece
        assert_equal 2, game_state.current_player_number
      end
    end

    describe 'when piece does not exist' do
      it 'does not change the board state' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'fuhyou' } ] },
            { player_number: 2, pieces: [] }
          ]
        )
        player_number = 1
        piece_id = 6 
        square_id = '62'

        result = game_state.drop(player_number, piece_id, square_id)

        hand = game_state.hands.find { |h| h.player_number == player_number }
        square = game_state.squares.find_by_id(square_id)

        refute result
        assert game_state.errors.find { |e| e.is_a?(JustShogi::PieceNotFoundError) }
        assert_equal 1, hand.pieces.size
        assert_nil square.piece
        assert_equal 1, game_state.current_player_number
      end
    end

    describe 'when destination does not exist' do
      it 'does not change the board state' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'fuhyou' } ] },
            { player_number: 2, pieces: [] }
          ]
        )
        player_number = 1
        piece_id = 5 
        square_id = '622'

        result = game_state.drop(player_number, piece_id, square_id)

        hand = game_state.hands.find { |h| h.player_number == player_number }

        refute result
        assert game_state.errors.find { |e| e.is_a?(JustShogi::OffBoardError) }
        assert_equal 1, hand.pieces.size
        assert_equal 1, game_state.current_player_number
      end
    end

    describe 'when destination is not empty' do
      it 'does not change the board state' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'fuhyou' } ] },
            { player_number: 2, pieces: [] }
          ]
        )
        player_number = 1
        piece_id = 5 
        square_id = '81'

        result = game_state.drop(player_number, piece_id, square_id)

        hand = game_state.hands.find { |h| h.player_number == player_number }
        square = game_state.squares.find_by_id(square_id)

        refute result
        assert game_state.errors.find { |e| e.is_a?(JustShogi::SquareOccupiedError) }
        assert_equal 1, hand.pieces.size
        refute_equal piece_id, square.piece.id
        assert_equal 1, game_state.current_player_number
      end
    end

    describe 'when drop prevents legal move' do
      it 'does not change board state' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'fuhyou' } ] },
            { player_number: 2, pieces: [] }
          ]
        )
        player_number = 1
        piece_id = 5
        square_id = '71'

        result = game_state.drop(player_number, piece_id, square_id)

        hand = game_state.hands.find { |h| h.player_number == player_number }
        square = game_state.squares.find_by_id(square_id)

        refute result
        refute game_state.errors.empty?
        assert_equal 1, hand.pieces.size
        assert_nil square.piece
        assert_equal 1, game_state.current_player_number
      end
    end

    describe 'when drop puts 2 fuhyou in file' do
      it 'does not change board state' do

      end
    end

    describe 'when drop leads to check' do
      it 'does not change the board state' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '92', x: 0, y: 1, piece: nil },
            { id: '93', x: 0, y: 2, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'hisha' } ] },
            { player_number: 2, pieces: [] }
          ]
        )
        player_number = 1
        piece_id = 5 
        square_id = '93'

        result = game_state.drop(player_number, piece_id, square_id)

        hand = game_state.hands.find { |h| h.player_number == player_number }
        square = game_state.squares.find_by_id(square_id)

        refute result
        assert game_state.errors.find { |e| e.is_a?(JustShogi::DroppedIntoCheckError) }
        assert_equal 1, hand.pieces.size
        assert_nil square.piece
        assert_equal 1, game_state.current_player_number
      end
    end
  end

  describe '#perform_complete_drop' do
    it 'changes the board state' do
      game_state = JustShogi::GameState.new(
        current_player_number: 1,
        squares: [
          { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
          { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
          { id: '71', x: 2, y: 0, piece: nil },
          { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

          { id: '62', x: 3, y: 1, piece: nil }
        ],
        hands: [
          { player_number: 1, pieces: [ { id: 5, player_number: 1, type: 'fuhyou' } ] },
          { player_number: 2, pieces: [] }
        ]
      )
      player_number = 1
      piece_id = 5
      square_id = '62'

      game_state.perform_complete_drop(player_number, piece_id, square_id)

      hand = game_state.hands.find { |h| h.player_number == player_number }
      square = game_state.squares.find_by_id(square_id)

      assert_equal 0, hand.pieces.size
      assert_instance_of JustShogi::Fuhyou, square.piece
      assert_equal 2, game_state.current_player_number
    end
  end

  describe '#winner' do
    describe 'player 1 in checkmate' do
      it 'returns 2' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: { id: 5, player_number: 1, type: 'fuhyou' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )

        assert_equal 2, game_state.winner
      end
    end

    describe 'player 2 in checkmate' do
      it 'returns 1' do
        game_state = JustShogi::GameState.new(
          current_player_number: 2,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 1, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 1, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 2, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: { id: 5, player_number: 2, type: 'fuhyou' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )

        assert_equal 1, game_state.winner
      end
    end

    describe 'neither player in checkmate' do
      it 'returns null' do
        game_state = JustShogi::GameState.default

        assert_nil game_state.winner
      end
    end
  end

  describe '#perform_complete_move' do
    describe 'when normal' do
      it 'changes the board' do
        game_state = JustShogi::GameState.default 
        from_id = '97'
        to_id = '96'

        result = game_state.perform_complete_move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        assert result
        assert_nil from.piece
        refute_nil to.piece
      end
    end

    describe 'when capturing' do
      it 'changes the board' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '82', x: 1, y: 1, piece: { id: 1, player_number: 1, type: 'fuhyou' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )
        from_id = '82'
        to_id = '81'

        result = game_state.perform_complete_move(1, from_id, to_id)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)
        hand = game_state.hands.find { |h| h.player_number == 1 }

        assert result
        assert_nil from.piece
        refute_nil to.piece
        assert_instance_of JustShogi::Fuhyou, to.piece
        assert_equal 1, hand.pieces.size
        assert_instance_of JustShogi::Hisha, hand.pieces.first
      end
    end

    describe 'when promoting' do
      it 'changes the board' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '72', x: 2, y: 1, piece: { id: 1, player_number: 1, type: 'fuhyou' } }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )
        from_id = '72'
        to_id = '71'
        promote = true

        result = game_state.perform_complete_move(1, from_id, to_id, promote)

        from = game_state.squares.find_by_id(from_id)
        to = game_state.squares.find_by_id(to_id)

        assert result
        assert_nil from.piece
        refute_nil to.piece
        assert_instance_of JustShogi::Tokin, to.piece
      end
    end
  end

  describe '#in_check?' do
    describe 'ou is threatened' do
      it 'must be in check' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )

        assert game_state.in_check?(1)
      end
    end

    describe 'ou is not threatened' do
      it 'must not be in check' do
        game_state = JustShogi::GameState.new(
          current_player_number: 1,
          squares: [
            { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
            { id: '81', x: 1, y: 0, piece: nil },
            { id: '71', x: 2, y: 0, piece: nil },
            { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

            { id: '62', x: 3, y: 1, piece: nil }
          ],
          hands: [
            { player_number: 1, pieces: [] },
            { player_number: 2, pieces: [] }
          ]
        )

        refute game_state.in_check?(1)
      end
    end
  end

  describe '#in_checkmate?' do
    describe 'when in check' do
      describe 'and ou cannot move' do
        it 'returns true' do
          game_state = JustShogi::GameState.new(
            current_player_number: 1,
            squares: [
              { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
              { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
              { id: '71', x: 2, y: 0, piece: nil },
              { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

              { id: '62', x: 3, y: 1, piece: { id: 5, player_number: 1, type: 'fuhyou' } }
            ],
            hands: [
              { player_number: 1, pieces: [] },
              { player_number: 2, pieces: [] }
            ]
          )

          assert game_state.in_checkmate?(1)
        end
      end

      describe 'and ou can move' do
        it 'returns false' do
          game_state = JustShogi::GameState.new(
            current_player_number: 1,
            squares: [
              { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
              { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
              { id: '71', x: 2, y: 0, piece: nil },
              { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

              { id: '62', x: 3, y: 1, piece: nil }
            ],
            hands: [
              { player_number: 1, pieces: [] },
              { player_number: 2, pieces: [] }
            ]
          )

          refute game_state.in_checkmate?(1)
        end
      end
    end

    describe 'not in check' do
      describe 'and non ou pieces cannot move' do
        describe 'and ou cannot move' do
          it 'returns true' do
            game_state = JustShogi::GameState.new(
              current_player_number: 1,
              squares: [
                { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
                { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
                { id: '71', x: 2, y: 0, piece: { id: 3, player_number: 1, type: 'fuhyou' } },
                { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

                { id: '62', x: 3, y: 1, piece: { id: 5, player_number: 1, type: 'fuhyou' } }
              ],
              hands: [
                { player_number: 1, pieces: [] },
                { player_number: 2, pieces: [] }
              ]
            )

            assert game_state.in_checkmate?(1)
          end
        end

        describe 'and ou can move' do
          it 'returns false' do
            game_state = JustShogi::GameState.new(
              current_player_number: 1,
              squares: [
                { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
                { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
                { id: '71', x: 2, y: 0, piece: { id: 3, player_number: 1, type: 'fuhyou' } },
                { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

                { id: '62', x: 3, y: 1, piece: nil }
              ],
              hands: [
                { player_number: 1, pieces: [] },
                { player_number: 2, pieces: [] }
              ]
            )

            refute game_state.in_checkmate?(1)
          end
        end
      end

      describe 'and non ou pieces can move' do
        it 'returns false' do
          game_state = JustShogi::GameState.new(
            current_player_number: 1,
            squares: [
              { id: '91', x: 0, y: 0, piece: { id: 1, player_number: 2, type: 'oushou' } },
              { id: '81', x: 1, y: 0, piece: { id: 2, player_number: 2, type: 'hisha' } },
              { id: '71', x: 2, y: 0, piece: { id: 3, player_number: 1, type: 'hisha' } },
              { id: '61', x: 3, y: 0, piece: { id: 4, player_number: 1, type: 'gyokushou' } },

              { id: '62', x: 3, y: 1, piece: { id: 5, player_number: 1, type: 'fuhyou' } }
            ],
            hands: [
              { player_number: 1, pieces: [] },
              { player_number: 2, pieces: [] }
            ]
          )

          refute game_state.in_checkmate?(1)
        end
      end
    end
  end
end

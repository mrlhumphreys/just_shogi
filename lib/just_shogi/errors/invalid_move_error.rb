require 'just_shogi/errors/error'

module JustShogi
  
  # = InvalidMoveError
  #
  # An invalid move error with a message
  class InvalidMoveError < Error

    # New invalid move errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new InvalidMoveError
    #   JustShogi::InvalidMoveError.new("Custom Message")
    def initialize(message="Move is invalid.")
      super 
    end
  end
end

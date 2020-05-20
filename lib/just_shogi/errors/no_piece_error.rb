require 'just_shogi/errors/error'

module JustShogi
  
  # = NoPieceError
  #
  # A no piece error with a message
  class NoPieceError < Error

    # New no piece errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new NoPieceError
    #   JustShogi::NoPieceError.new("Custom Message")
    def initialize(message="There is no piece to move.")
      super 
    end
  end
end

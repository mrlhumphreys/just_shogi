require 'just_shogi/errors/error'

module JustShogi

  # = PieceNotFoundError
  #
  # An piece not found error with a message
  class PieceNotFoundError < Error

    # New piece not found errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new PieceNotFoundError 
    #   JustShogi::PieceNotFoundError.new("Custom Message")
    def initialize(message="The piece could not be found.")
      super
    end
  end
end

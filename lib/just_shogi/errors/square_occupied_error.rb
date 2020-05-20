require 'just_shogi/errors/error'

module JustShogi

  # = SquareOccupiedError
  #
  # A square occupied error with a message
  class SquareOccupiedError < Error

    # New invalid promotion errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new SquareOccupiedError 
    #   JustShogi::SquareOccupiedError.new("Custom Message")
    def initialize(message="Square is already occupied.")
      super
    end
  end
end

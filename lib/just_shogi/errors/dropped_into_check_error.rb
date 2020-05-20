require 'just_shogi/errors/error'

module JustShogi

  # = DroppedIntoCheckError
  #
  # A dropped into check error with a message
  class DroppedIntoCheckError < Error

    # New moved into check errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new DroppedIntoCheckError
    #   JustShogi::DroppedIntoCheckError.new("Custom Message")
    def initialize(message="This move would leave the ou in check.")
      super
    end
  end
end

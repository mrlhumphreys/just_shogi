require 'just_shogi/errors/error'

module JustShogi

  # = InvalidPromotionError
  #
  # An invalid promotion error with a message
  class InvalidPromotionError < Error

    # New invalid promotion errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new InvalidPromotionError 
    #   JustShogi::InvalidPromotionError.new("Custom Message")
    def initialize(message="This piece cannot promote.")
      super
    end
  end
end

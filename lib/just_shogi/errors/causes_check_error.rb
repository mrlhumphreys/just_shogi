require 'just_shogi/errors/error'

module JustShogi
  
  # = CausesCheckError
  #
  # A causes check error with a message
  class CausesCheckError < Error

    # New causes check errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new CausesCheckError
    #   JustShogi::CausesCheckError.new("Custom Message")
    def initialize(message="That move would put the ou in check.")
      super 
    end
  end
end

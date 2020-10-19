require 'just_shogi/errors/error'

module JustShogi

  # = TwoFuhyouInFileError 
  #
  # A two fuhyou in file error with a message
  class TwoFuhyouInFileError < Error

    # New two fuhyou in file errors can be instantiated with
    #
    # @option [String] message
    #   the message to display.
    #
    # ==== Example:
    #   # Instantiates a new TwoFuhyouInFileError 
    #   JustShogi::TwoFuhyouInFileError.new("Custom Message")
    def initialize(message="Cannot place two fuhyou in the same file.")
      super
    end
  end
end

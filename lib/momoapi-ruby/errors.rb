# frozen_string_literal: true

# Error handling for unsuccessful responses from the MTN Momo API

module Error
  class APIError < StandardError
    def initialize(message, code)
      @code = code
      super("Error - code #{code}, message: #{message}")
    end
  end
end

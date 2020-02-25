# frozen_string_literal: true

module Error
  class APIError < StandardError
    def initialize(message, code)
      @code = code
      super("Error - code #{code}, message: #{message}")
    end
  end
end

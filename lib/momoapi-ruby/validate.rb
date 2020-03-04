# frozen_string_literal: true

# Validations for parameters passed into client methods

require 'momoapi-ruby/errors'

module Momoapi
  class Validate
    def validate(phone_number, amount, currency)
      validate_string?(phone_number, 'Phone number')
      validate_numeric?(amount, 'Amount')
      validate_string?(currency, 'Currency')
    end

    def validate_numeric?(num, field)
      return true if num.is_a? Numeric

      raise Momoapi::ValidationError, "#{field} should be a number"
    end

    def validate_string?(str, field)
      return true if str.is_a? String

      raise Momoapi::ValidationError, "#{field} should be a string"
    end
  end
end

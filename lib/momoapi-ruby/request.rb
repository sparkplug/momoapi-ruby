# frozen_string_literal: true

require 'faraday'

class Request
  def initialize(method, path, headers, body)
    @method = method.downcase
    @url = 'https://sandbox.momodeveloper.mtn.com'
    @path = path
    @headers = headers
    @body = body
  end
end

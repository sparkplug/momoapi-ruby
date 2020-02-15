# frozen_string_literal: true

require 'faraday'

class Request
  def initialize(method, url, headers, body = {})
    @method = method.downcase
    @url = url
    @headers = headers
    @body = body
  end

  def request
    case @method
    when 'get'
      response = Faraday.get(@url) do |req|
        @headers.each { |k, v| req.headers[k] = v } unless @headers.empty?
        req.body = @body.to_json
      end
      response.status
    when 'post'
      response = Faraday.post(@url) do |req|
        @headers.each { |k, v| req.headers[k] = v } unless @headers.empty?
        req.body = @body.to_json
      end
      response.status
    end
  end

  def interpret_response
    response_code = response.status
    response_body = response.body
    {
      body: response_body,
      code: response_code
    }
  end

  def handle_error_response
    # TO DO: Add error handling
  end
end

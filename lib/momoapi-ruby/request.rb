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

  def send_request
    username = Momoapi.config.collection_user_id
    password = Momoapi.config.collection_api_secret
    conn = Faraday.new(url: @url)
    conn.headers = @headers
    conn.basic_auth(username, password)

    case @method
    when 'get'
      @resp = conn.get(@path)
    when 'post'
      @resp = conn.post(@path)
    end
    puts @resp
    puts @resp.inspect
    puts interpret_response(@resp)
  end

  def interpret_response(response)
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

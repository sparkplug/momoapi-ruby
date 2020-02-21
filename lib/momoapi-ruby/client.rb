# frozen_string_literal: true

require 'faraday'

require 'momoapi-ruby/config'
require 'momoapi-ruby/errors'

module Momoapi
  class Client
    def send_request(method, path, headers, *_body)
      auth_token = get_auth_token['access_token']
      conn = Faraday.new(url: Momoapi.config.base_url)
      conn.headers = headers
      conn.authorization(:Bearer, auth_token)

      case method
      when 'get'
        response = conn.get(path)
      when 'post'
        response = conn.post(path)
      end
      interpret_response(response)
    end

    def interpret_response(resp)
      response = {
        body: JSON.parse(resp.body),
        code: resp.status
      }
      # unless 200 <= resp.status && resp.status < 300
      #   handle_error(response[:code], response[:body])
      # end
      response
    end

    # def handle_error(response_code, response_body)
    #   raise APIError(response_code, response_body)
    # end

    def get_auth_token(path, subscription_key)
      headers = {
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      username = Momoapi.config.collection_user_id
      password = Momoapi.config.collection_api_secret
      url = Momoapi.config.base_url
      conn = Faraday.new(url: url)
      conn.headers = headers
      conn.basic_auth(username, password)
      response = conn.post(path)
      JSON.parse(response.body)
    end

    def get_balance(path, subscription_key)
      headers = {
        "X-Target-Environment": 'sandbox',
        "Content-Type": 'application/json',
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      send_request('get', path, headers)
    end

    def get_transaction_status(path, subscription_key)
      headers = {
        "X-Target-Environment": 'sandbox',
        "Content-Type": 'application/json',
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      send_request('get', path, headers)
    end
  end
end

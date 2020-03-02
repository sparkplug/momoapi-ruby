# frozen_string_literal: true

# Base implementation of the MTN API client

# Includes methods common to collections, disbursements and remittances

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
      body = resp.body.empty? ? '' : JSON.parse(resp.body)
      response = {
        body: body,
        code: resp.status
      }
      unless resp.status >= 200 && resp.status < 300
        handle_error(response[:body], response[:code])
      end
      response
    end

    def handle_error(response_body, response_code)
      raise Error::APIError.new(response_body, response_code)
    end

    # Create an  access token which can then be used to
    # authorize and authenticate towards the other end-points of the API
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
      begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body.to_s
      end
    end

    def prepare_get_request(path, subscription_key)
      headers = {
        "X-Target-Environment": Momoapi.config.environment || 'sandbox',
        "Content-Type": 'application/json',
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      send_request('get', path, headers)
    end

    # get the balance on an account
    def get_balance(path, subscription_key)
      prepare_get_request(path, subscription_key)
    end

    # retrieve transaction information, for transfer and payments
    def get_transaction_status(path, subscription_key)
      prepare_get_request(path, subscription_key)
    end

    # check if an account holder is registered and active in the system
    def is_user_active(path, subscription_key)
      prepare_get_request(path, subscription_key)
    end
  end
end

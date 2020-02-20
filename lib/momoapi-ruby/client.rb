# frozen_string_literal: true

require 'faraday'
require 'pry'

require 'momoapi-ruby/config'
require 'momoapi-ruby/request'

module Momoapi
  class Client
    def send_request(method, path, headers, _body)
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
      # puts interpret_response(resp)
      puts response.inspect
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
      body = {}
      send_request('get', path, headers, body)
    end

    def get_transaction_status(_transaction_id, path, subscription_key)
      headers = {
        "X-Target-Environment": 'sandbox',
        "Content-Type": 'application/json',
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      body = {}
      send_request('get', path, headers, body).send_request
    end
  end
end

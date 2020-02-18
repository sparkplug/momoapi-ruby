# frozen_string_literal: true

require 'momoapi-ruby/config'
require 'momoapi-ruby/request'

module Momoapi
  class Client
    def initialize; end

    def get_auth_token(path, subscription_key)
      headers = {
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      body = {}
      r = Request.new('post', path, headers, body)
      r.send_request
    end

    def get_balance(path, subscription_key)
      headers = {
        "X-Target-Environment": 'sandbox',
        "Content-Type": 'application/json',
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      body = {}
      r = Request.new('get', path, headers, body)
      r.send_request
    end

    def get_transaction_status(_transaction_id, path, subscription_key)
      headers = {
        "X-Target-Environment": 'sandbox',
        "Content-Type": 'application/json',
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      body = {}
      Request.new('get', path, headers, body).send_request
    end
  end
end

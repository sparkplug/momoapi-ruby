# frozen_string_literal: true

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
      response = r.request
      puts response
    end

    def get_balance; end

    def get_transaction_status; end
  end
end

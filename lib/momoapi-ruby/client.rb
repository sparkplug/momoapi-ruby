# frozen_string_literal: true

require 'momoapi-ruby/request'

module Momoapi
  class Client
    def initialize; end

    def get_auth_token(_product, url, subscription_key)
      headers = {
        "Content-Type": 'application/json',
        "Ocp-Apim-Subscription-Key": subscription_key
      }
      r = Request.new('post', url, headers)
      response = r.request
      puts response
    end

    def get_balance; end

    def get_transaction_status; end
  end
end

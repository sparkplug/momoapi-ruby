# frozen_string_literal: true

require 'momoapi-ruby/client'

module Momoapi
  class Collection < Client
    def get_auth_token
      url = 'https://sandbox.momodeveloper.mtn.com/collection/token/'
      super('COLLECTIONS', url, 'fa974cf4f0ae435c9278205a71206f1b')
    end

    def get_balance; end

    def get_transaction_status; end

    def request_to_pay; end
  end
end

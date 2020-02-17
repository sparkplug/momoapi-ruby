# frozen_string_literal: true

require 'momoapi-ruby/client'

module Momoapi
  class Collection < Client
    def get_auth_token
      path = 'collection/token/'
      super(path, 'b5e0f061fa5a4cbbbd2192530b7cedfb')
    end

    def get_balance; end

    def get_transaction_status; end

    def request_to_pay; end
  end
end

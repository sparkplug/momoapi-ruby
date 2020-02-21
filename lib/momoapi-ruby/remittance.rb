# frozen_string_literal: true

require 'momoapi-ruby/config'
require 'momoapi-ruby/client'

module Momoapi
  class Remittance < Client
    def get_auth_token
      path = 'remittance/token'
      super(path, Momoapi.config.remittance_primary_key)
    end

    def get_balance
      path = '/remittance/v1_0/account/balance'
      super(path, Momoapi.config.remittance_primary_key)
    end

    def get_transaction_status(transaction_id)
      path = "/remittance/v1_0/transfer/#{transaction_id}"
      super(path, Momoapi.config.remittance_primary_key)
    end

    def transfer; end
  end
end

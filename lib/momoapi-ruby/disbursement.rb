# frozen_string_literal: true

require 'momoapi-ruby/config'
require 'momoapi-ruby/client'

module Momoapi
  class Disbursement < Client
    def get_auth_token
      path = 'disbursement/token'
      super(path, Momoapi.config.disbursement_primary_key)
    end

    def get_balance
      path = '/disbursement/v1_0/account/balance'
      super(path, Momoapi.config.disbursement_primary_key)
    end

    def get_transaction_status(transaction_id)
      path = "/disbursement/v1_0/transfer/#{transaction_id}"
      super(path, Momoapi.config.disbursement_primary_key)
    end

    def transfer; end
  end
end

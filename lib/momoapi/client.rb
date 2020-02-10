# frozen_string_literal: true

module Momoapi
  class ClientInterface
  end

  class Client < ClientInterface
    def fetch_auth_token; end

    def fetch_balance; end

    def fetch_transaction_status; end
  end
end

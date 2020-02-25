# frozen_string_literal: true

require 'securerandom'

require 'momoapi-ruby/config'
require 'momoapi-ruby/client'

module Momoapi
  class Collection < Client
    def get_auth_token
      path = 'collection/token/'
      super(path, Momoapi.config.collection_primary_key)
    end

    def get_balance
      path = '/collection/v1_0/account/balance'
      super(path, Momoapi.config.collection_primary_key)
    end

    def get_transaction_status(transaction_id)
      path = "/collection/v1_0/requesttopay/#{transaction_id}"
      super(path, Momoapi.config.collection_primary_key)
    end

    def request_to_pay(phone_number, amount, external_id,
                       payee_note = '', payer_message = '', currency = 'EUR')
      uuid = SecureRandom.uuid
      headers = {
        "X-Target-Environment": Momoapi.config.environment || 'sandbox',
        "Content-Type": 'application/json',
        "X-Reference-Id": uuid,
        "Ocp-Apim-Subscription-Key": Momoapi.config.collection_primary_key
      }
      body = {
        "payer": {
          "partyIdType": 'MSISDN',
          "partyId": phone_number
        },
        "payeeNote": payee_note,
        "payerMessage": payer_message,
        "externalId": external_id,
        "currency": currency,
        "amount": amount.to_s
      }
      path = '/collection/v1_0/requesttopay'
      send_request('post', path, headers, body)
      { transaction_reference: uuid }
    end
  end
end

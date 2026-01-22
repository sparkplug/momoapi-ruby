# frozen_string_literal: true

# Implementation of the MTN API remittances client

require 'momoapi-ruby/config'
require 'momoapi-ruby/client'

module Momoapi
  class Remittance < Client
    def get_auth_token
      path = 'remittance/token/'
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

    # The transfer operation is used to transfer an amount from the owner’s
    # account to a payee account.
    # The status of the transaction can be validated
    # by using `get_transation_status`
    def transfer(phone_number, amount, external_id,
                 payee_note = '', payer_message = '',
                 currency = 'EUR', callback_url = '')
      Momoapi::Validate.new.validate(phone_number, amount, currency)
      uuid = SecureRandom.uuid
      headers = {
        "X-Target-Environment": Momoapi.config.environment || 'sandbox',
        "Content-Type": 'application/json',
        "X-Reference-Id": uuid,
        "Ocp-Apim-Subscription-Key": Momoapi.config.remittance_primary_key
      }
      headers['X-Callback-Url'] = callback_url unless callback_url.empty?
      body = {
        "payee": {
          "partyIdType": 'MSISDN',
          "partyId": phone_number
        },
        "payeeNote": payee_note,
        "payerMessage": payer_message,
        "externalId": external_id,
        "currency": currency,
        "amount": amount.to_s
      }
      path = '/remittance/v1_0/transfer'
      send_request('post', path, headers, body)
      { transaction_reference: uuid }
    rescue Exception => error
      if uuid
        class << error
          attr_accessor :transaction_reference
        end
        error.transaction_reference = uuid
      end
      raise error
    end

    def is_user_active(phone_number)
      path = "/remittance/v1_0/accountholder/msisdn/#{phone_number}/active"
      super(path, Momoapi.config.remittance_primary_key)
    end
  end
end

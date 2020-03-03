# frozen_string_literal: true

# Implementation of the MTN API disbursements client

require 'momoapi-ruby/config'
require 'momoapi-ruby/client'

module Momoapi
  class Disbursement < Client
    def get_auth_token
      path = 'disbursement/token/'
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

    # The transfer operation is used to transfer an amount from the owner’s
    # account to a payee account.
    # The status of the transaction can be validated
    # by using `get_transation_status`
    def transfer(phone_number, amount, external_id,
                 payee_note = '', payer_message = '',
                 currency = 'EUR', callback_url = '')
      uuid = SecureRandom.uuid
      headers = {
        "X-Target-Environment": Momoapi.config.environment || 'sandbox',
        "Content-Type": 'application/json',
        "X-Reference-Id": uuid,
        "Ocp-Apim-Subscription-Key": Momoapi.config.disbursement_primary_key
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
      path = '/disbursement/v1_0/transfer'
      send_request('post', path, headers, body)
      { transaction_reference: uuid }
    end

    def is_user_active(phone_number)
      path = "/disbursement/v1_0/accountholder/msisdn/#{phone_number}/active"
      super(path, Momoapi.config.disbursement_primary_key)
    end
  end
end

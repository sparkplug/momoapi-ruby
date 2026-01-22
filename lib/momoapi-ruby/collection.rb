# frozen_string_literal: true

# Implementation of the MTN API collections client

require 'securerandom'

require 'momoapi-ruby/config'
require 'momoapi-ruby/client'
require 'momoapi-ruby/validate'

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

    # This method is used to request a payment from a consumer (Payer).
    # The payer will be asked to authorize the payment. The transaction will
    # be executed once the payer has authorized the payment.
    # The requesttopay will be in status PENDING until the transaction
    # is authorized or declined by the payer or it is timed out by the system.
    # The status of the transaction can be validated
    # by using `get_transation_status`
    def request_to_pay(phone_number, amount, external_id,
                       payee_note = '', payer_message = '',
                       currency = 'EUR', callback_url = '')
      Momoapi::Validate.new.validate(phone_number, amount, currency)
      uuid = SecureRandom.uuid
      headers = {
        "X-Target-Environment": Momoapi.config.environment || 'sandbox',
        "Content-Type": 'application/json',
        "X-Reference-Id": uuid,
        "Ocp-Apim-Subscription-Key": Momoapi.config.collection_primary_key
      }
      headers['X-Callback-Url'] = callback_url unless callback_url.empty?
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
      path = "/collection/v1_0/accountholder/msisdn/#{phone_number}/active"
      super(path, Momoapi.config.collection_primary_key)
    end
  end
end

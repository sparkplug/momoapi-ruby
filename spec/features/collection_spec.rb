# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Momoapi::Collection do
  before(:all) do
    Momoapi.configure do |config|
      config.base_url = 'https://sandbox.momodeveloper.mtn.com'
      config.callback_host = 'https://webhook.site/8e412414-2154-4d06-90c4-5e141c9f2910'
      config.collection_primary_key = 'b5e0f061fa5a4cbbbd2192530b7cedfb'
      config.collection_user_id = '783a8f21-3fc6-4e39-aa76-da8e562fba7e'
      config.collection_api_secret = '313cfaf9a40b4029b7139f4c9d8afb23'
    end
  end

  describe 'collections', vcr: { record: :new_episodes } do
    it 'gets balance' do
      # response = Momoapi::Collection.new.get_balance
      # expect(response).to have_http_status 200
      expect { Momoapi::Collection.new.get_balance }
        .to raise_error(Error::APIError)
    end

    it 'gets transaction status' do
      ref = '888a79ff-0535-4a9f-8a66-457f7903bd8a'
      response = Momoapi::Collection.new.get_transaction_status(ref)
      expect(response[:code]).to eq(200)
    end

    it 'makes request to pay' do
      expect do
        Momoapi::Collection.new.request_to_pay(
          '0775671360',
          '5.0', '6353636',
          'testing', 'testing', 'EUR'
        )
      end .to raise_error(Error::APIError)
    end
  end
end

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
    it 'checks if user is active' do
      response = Momoapi::Collection.new.is_user_active('0243656543')
      expect(response).to be_a_kind_of(Hash)
    end

    it 'gets balance' do
      expect { Momoapi::Collection.new.get_balance }
        .to raise_error(Momoapi::Error)
    end

    it 'gets transaction status' do
      ref = '3700b523-c5d9-446e-8c01-a6261903a9ba'
      expect { Momoapi::Collection.new.get_transaction_status(ref) }
        .to raise_error(Momoapi::Error)
    end

    context 'when error' do
      let(:tx_id) { 'ef7e29c9-ddd2-420b-85a5-5373ca1a48d4' }

      before do
        allow(SecureRandom).to receive(:uuid).and_return(tx_id)
        allow_any_instance_of(described_class).to receive(:send_request).and_raise(Momoapi::Error.new('test error', '400'))
      end

      after do
        allow(SecureRandom).to receive(:uuid).and_call_original
        allow_any_instance_of(described_class).to receive(:send_request).and_call_original
      end

      it 'stores tx reference id in error object' do
        expect do
          Momoapi::Collection.new.request_to_pay(
            '0775671360',
            5.0, '6353636',
            'testing', 'testing', 'EUR'
          )
        end .to raise_error(Momoapi::Error) do |error|
          expect(error.transaction_reference).to eql(tx_id)
        end
      end
    end

    context 'when no errors' do
      let(:tx_id) { 'f2edf507-b754-4a33-9995-177cd9aa217b' }

      before do
        allow(SecureRandom).to receive(:uuid).and_return(tx_id)
      end

      after do
        allow(SecureRandom).to receive(:uuid).and_call_original
      end

      it 'makes request to pay' do
        res = Momoapi::Collection.new.request_to_pay(
            '0775671360',
            5.0, '6353636',
            'testing', 'testing', 'EUR'
          )
        expect(res).to eql(transaction_reference: tx_id)
      end
    end
  end
end

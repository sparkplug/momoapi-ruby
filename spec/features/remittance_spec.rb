# frozen_string_literal: true

require 'spec_helper'
require 'faraday'
require 'pry'

RSpec.describe Momoapi::Remittance do
  before(:all) do
    Momoapi.configure do |config|
      config.base_url = 'https://sandbox.momodeveloper.mtn.com'
      config.callback_host = 'https://webhook.site/8e412414-2154-4d06-90c4-5e141c9f2910'
      config.remittance_primary_key = 'd314b91c889340b682a9a3144a9ffd1b'
      config.remittance_user_id = 'cf028de4-7341-41c0-b4ff-3fa190b77236'
      config.remittance_api_secret = 'dcacc115e6fd4669b1db622d4b949947'
      config.faraday_block = Proc.new do |f|
        f.use Faraday::Response::Logger
      end
    end
  end

  describe 'remittances', vcr: { record: :new_episodes } do
    it 'checks if user is active' do
      response = Momoapi::Remittance.new.is_user_active('0243656543')
      expect(response).to be_a_kind_of(Hash)
    end

    it 'gets balance' do
      expect { Momoapi::Remittance.new.get_balance }
        .to raise_error(Momoapi::Error)
    end

    it 'gets transaction status' do
      ref = '888a79ff-0535-4a9f-8a66-457f7903bd8ab'
      expect { Momoapi::Remittance.new.get_transaction_status(ref) }
        .to raise_error(Momoapi::Error)
    end

    context '#transfer' do

      context 'when error' do
        let(:tx_id) { 'ef7e29c9-ddd2-420b-85a5-5373ca1a48dd' }

        before do
          allow(SecureRandom).to receive(:uuid).and_return(tx_id)
          allow_any_instance_of(described_class).to receive(:send_request).and_raise(Momoapi::Error.new('test error', '400'))
        end

        after do
          allow(SecureRandom).to receive(:uuid).and_call_original
          allow_any_instance_of(described_class).to receive(:send_request).and_call_original
        end

        it 'raises error with preset tx id' do
          expect do
            res = Momoapi::Remittance.new.transfer(
              '0775671360',
              5.0, '6353636',
              'testing', 'testing', 'EUR'
            )
          end .to raise_error(Momoapi::Error) do |error|
            expect(error.transaction_reference).to eql(tx_id)
          end
        end
      end

      # TODO: add VCRs and generate all API responses
      context 'when no errors' do
        let(:tx_id) { 'ef7e29c9-ddd2-420b-85a5-5373ca2a48dd' }

        before do
          allow(SecureRandom).to receive(:uuid).and_return(tx_id)
        end

        after do
          allow(SecureRandom).to receive(:uuid).and_call_original
        end

        it 'creates tx' do
          res = Momoapi::Remittance.new.transfer(
            '0775671360',
            5.0, '6353636',
            'testing', 'testing', 'EUR'
          )
          expect(res).to eql({transaction_reference: tx_id})
        end
      end
    end
  end
end

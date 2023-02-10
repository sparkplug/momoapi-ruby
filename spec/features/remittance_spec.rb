# frozen_string_literal: true

require 'spec_helper'

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

    it 'makes transfer' do
      expect do
        Momoapi::Remittance.new.transfer(
          '0775671360',
          5.0, '6353636',
          'testing', 'testing', 'EUR'
        )
      end .to raise_error(Momoapi::Error)
    end
  end
end

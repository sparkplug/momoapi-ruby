# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Momoapi::Disbursement do
  before(:all) do
    Momoapi.configure do |config|
      config.base_url = 'https://sandbox.momodeveloper.mtn.com'
      config.callback_host = 'https://webhook.site/8e412414-2154-4d06-90c4-5e141c9f2910'
      config.disbursement_primary_key = '0c74e0a1cf344d45a3d02b1da52c12f5'
      config.disbursement_user_id = 'ede69da6-eec7-4b48-86c4-faf65cd05726'
      config.disbursement_api_secret = '066eec5710404d78a0b0923058014ce7'
    end
  end

  describe 'disbursements', vcr: { record: :new_episodes } do
    it 'checks if user is active' do
      response = Momoapi::Disbursement.new.is_user_active('0243656543')
      expect(response).to be_a_kind_of(Hash)
    end

    it 'gets balance' do
      expect { Momoapi::Disbursement.new.get_balance }
        .to raise_error(Momoapi::Error)
    end

    it 'gets transaction status' do
      ref = '888a79ff-0535-4a9f-8a66-457f7903bd8ab'
      expect { Momoapi::Disbursement.new.get_transaction_status(ref) }
        .to raise_error(Momoapi::Error)
    end

    it 'makes transfer' do
      expect do
        Momoapi::Disbursement.new.transfer(
          '0775671360',
          5.0, '6353636',
          'testing', 'testing', 'EUR'
        )
      end .to raise_error(Momoapi::Error)
    end
  end
end

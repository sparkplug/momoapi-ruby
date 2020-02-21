# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Momoapi::Collection do
  before do
    Momoapi.configure do |config|
      config.base_url = 'https://sandbox.momodeveloper.mtn.com'
      config.callback_host = 'https://webhook.site/8e412414-2154-4d06-90c4-5e141c9f2910'
      config.collection_primary_key = 'b5e0f061fa5a4cbbbd2192530b7cedfb'
      config.collection_user_id = '783a8f21-3fc6-4e39-aa76-da8e562fba7e'
      config.collection_api_secret = '313cfaf9a40b4029b7139f4c9d8afb23'
    end
  end

  # context 'valid credentials' do
  #   it 'generates an auth token' do
  #     @collection = Momoapi::Collection.new
  #     @collection.get_auth_token
  #     # expect(token).to have_http_status 200
  #   end
  # end
end

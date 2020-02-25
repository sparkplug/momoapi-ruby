# frozen_string_literal: true

require 'bundler/setup'
require 'momoapi-ruby'
require 'webmock/rspec'
require 'vcr'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    stub_request(:get, /sandbox.momodeveloper.mtn.com/)
      .with(headers: {
              "X-Target-Environment": 'sandbox',
              "Content-Type": 'application/json',
              "X-Reference-Id": SecureRandom.uuid,
              "Ocp-Apim-Subscription-Key": Momoapi.config.collection_primary_key
            })
      .to_return(status: 200, body: 'stubbed_response', headers: {})
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

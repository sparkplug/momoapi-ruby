# frozen_string_literal: true

# Configurations are set up in this file
# for a user's MTN MoMo API user credentials

module Momoapi
  class Config
    attr_writer   :base_url
    attr_accessor :environment,
                  :callback_host, :collection_primary_key,
                  :collection_user_id, :collection_api_secret,
                  :disbursement_primary_key, :disbursement_user_id,
                  :disbursement_api_secret, :remittance_primary_key,
                  :remittance_user_id, :remittance_api_secret, :faraday_block

    def initialize
      @environment = nil
      @base_url = nil
      @callback_host = nil
      @collection_primary_key = nil
      @collection_user_id = nil
      @collection_api_secret = nil
      @disbursement_primary_key = nil
      @disbursement_user_id = nil
      @disbursement_api_secret = nil
      @remittance_primary_key = nil
      @remittance_user_id = nil
      @remittance_api_secret = nil
      @faraday_block = nil # pass Proxy
    end

    def base_url
      @base_url || 'https://ericssonbasicapi2.azure-api.net'
    end
  end
end

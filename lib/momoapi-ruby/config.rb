# frozen_string_literal: true

module Momoapi
  class Config
    attr_accessor :environment, :base_url,
                  :callback_host, :collection_primary_key,
                  :collection_user_id, :collection_api_secret

    def initialize
      @environment = nil
      @base_url = nil
      @callback_host = nil
      @collection_primary_key = nil
      @collection_user_id = nil
      @collection_api_secret = nil
    end
  end
end

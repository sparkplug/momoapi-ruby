# frozen_string_literal: true

require 'momoapi'
require 'httparty'
require 'uuid'

module Momoapi
  # class that holds CLI commands
  class CLI
    def create_sandbox_user(host, key)
      puts 'Creating MoMo Sandbox user'
      uuid = UUID.new.generate
      response = make_api_request(host, key, uuid)

      puts response
    end

    def make_api_request(host, key, id)
      body = { "providerCallbackHost": host }
      headers = {
        'X-Reference-Id' => id,
        'Ocp-Apim-Subscription-Key' => key,
        'Content-Type' => 'application/json'
      }
      HTTParty.post('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser',
                    headers: headers,
                    body: body)
    end
  end
end

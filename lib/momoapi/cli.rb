# frozen_string_literal: true

require 'momoapi'
require 'httparty'
require 'uuid'

module Momoapi
  class CLI
    def create_sandbox_user(option)
      puts 'Creating MoMo Sandbox user'
      uuid = UUID.new.generate
      host = option[:host]
      key = option[:key]
      make_api_request(host, key, uuid)
      response = generate_api_key(uuid, key)
    end

    def make_api_request(host, key, id)
      body = { "providerCallbackHost": host }
      headers = {
        'X-Reference-Id' => id,
        'Ocp-Apim-Subscription-Key' => key,
        'Content-Type' => 'application/json'
      }
      response = HTTParty.post('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser',
                    body: body,
                    headers: headers)
      if response.code == 201
        puts "Sandbox user created"
      else 
        puts "Error creating user"
      end
    end

    def generate_api_key(uuid, key)
      headers = {
        'Ocp-Apim-Subscription-Key' => key
      }
      url = "https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/#{uuid}/apikey"
      response = HTTParty.post(url, headers: headers)
      if response.code == 201
        puts response.parsed_response
      else 
        puts "Error creating API key"
      end
    end
  end
end

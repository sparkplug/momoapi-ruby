# frozen_string_literal: true

require 'momoapi'
require 'httparty'
require 'uuid'

module Momoapi
  class CLI
    def initialize(option)
      @uuid = UUID.new.generate
      @host = option[:host]
      @key = option[:key]
      create_sandbox_user
    end

    def create_sandbox_user
      body = { "providerCallbackHost": @host }
      headers = {
        'X-Reference-Id' => @uuid,
        'Ocp-Apim-Subscription-Key' => @key
      }
      response = HTTParty.post('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser',
                               body: body,
                               options: { headers: headers })
      if response.code == 201
        puts 'Sandbox user created'
        generate_api_key
      else
        puts response.parsed_response['message']
      end
    end

    def generate_api_key
      headers = {
        'Ocp-Apim-Subscription-Key' => @key
      }
      url = "https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/#{@uuid}/apikey"
      response = HTTParty.post(url, headers: headers)
      if response.code == 201
        puts "User ID: #{@uuid} \n API key: #{response.parsed_response.apikey}"
      else
        puts 'Error creating API key'
      end
    end
  end
end

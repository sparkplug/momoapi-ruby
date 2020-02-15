# frozen_string_literal: true

require 'momoapi-ruby'
require 'faraday'
require 'json'

module Momoapi
  class CLI
    def initialize(option)
      @uuid = Faraday.get('https://www.uuidgenerator.net/api/version4').body.chomp
      @host = option[:host]
      @key = option[:key]
      create_sandbox_user
    end

    def create_sandbox_user
      body = { "providerCallbackHost": @host }
      @url = 'https://sandbox.momodeveloper.mtn.com/v1_0/apiuser'
      response = Faraday.post(@url) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Reference-Id'] = @uuid
        req.headers['Ocp-Apim-Subscription-Key'] = @key
        req.body = body.to_json
      end
      if response.status == 201
        generate_api_key
      else
        # TO DO: Add error handling here
        puts response.body
      end
    end

    def generate_api_key
      @url = 'https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/' +
             @uuid + '/apikey'
      puts @url
      response = Faraday.post(@url) do |req|
        req.headers['Ocp-Apim-Subscription-Key'] = @key
      end
      if response.status == 201
        puts " User ID: #{@uuid} \n API key: #{response.body}"
      else
        # TO DO: Add error handling here
        puts 'Error creating API key'
      end
    end
  end
end

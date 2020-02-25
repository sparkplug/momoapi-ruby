# frozen_string_literal: true

require 'faraday'
require 'json'
require 'securerandom'

require 'momoapi-ruby/config'
require 'momoapi-ruby/errors'
require 'momoapi-ruby'

module Momoapi
  class CLI
    def initialize(option)
      @uuid = SecureRandom.uuid
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

      unless response.status == 201
        raise Error::APIError.new(response.body, response.status)
      end

      generate_api_key
    end

    def generate_api_key
      @url = 'https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/' +
             @uuid + '/apikey'
      response = Faraday.post(@url) do |req|
        req.headers['Ocp-Apim-Subscription-Key'] = @key
      end

      unless response.status == 201
        raise Error::APIError.new(response.body, response.status)
      end

      key = JSON.parse(response.body)
      puts "\n User ID: #{@uuid} \n API key: #{key['apiKey']} \n\n"
    end
  end
end

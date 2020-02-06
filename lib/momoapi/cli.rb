# frozen_string_literal: true

require 'momoapi'
require 'httparty'

module Momoapi
  # class that holds CLI commands
  class CLI
    def self.create_sandbox_user(host, key)
      puts 'Creating MoMo user'

      uuid = UUID.new
      id = uuid.generate
      
      body = { "providerCallbackHost": host }
      headers = {
        "X-Reference-Id" => id,
        "Ocp-Apim-Subscription-Key" => key,
        "Content-Type" => "application/json"
        }

        HTTParty.post("https://sandbox.momodeveloper.mtn.com/v1_0/apiuser", 
          headers: headers,
          body: body
        )
    end
  end
end

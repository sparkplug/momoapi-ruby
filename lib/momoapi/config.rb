# frozen_string_literal: true

module Momoapi
  class Config
    attr_accessor :host, :key

    def initialize
      @host = nil
      @key = nil
    end
  end
end

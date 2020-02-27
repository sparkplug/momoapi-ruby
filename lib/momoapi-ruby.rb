# frozen_string_literal: true

require 'momoapi-ruby/config'
require 'momoapi-ruby/version'
require 'momoapi-ruby/cli'
require 'momoapi-ruby/collection'
require 'momoapi-ruby/disbursement'

module Momoapi
  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end
end

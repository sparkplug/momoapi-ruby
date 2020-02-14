# frozen_string_literal: true

require 'momoapi/config'
require 'momoapi/ruby/version'
require 'momoapi/cli'

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

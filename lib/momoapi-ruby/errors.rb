# frozen_string_literal: true

class APIError < StandardError
  def initialize(_title, code, message)
    super(title: title, status: code, detail: message)
  end
end

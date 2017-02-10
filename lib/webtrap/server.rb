# frozen_string_literal: true
require "sinatra"

module WebTrap
  class Server < Sinatra::Base
    @payload_was_valid = false
    @request_received = false

    class << self
      attr_writer :payload_was_valid
      attr_writer :request_received
    end

    def self.payload_was_valid?
      @payload_was_valid
    end

    def self.request_received?
      @request_received
    end
  end
end

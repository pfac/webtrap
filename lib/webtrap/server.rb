# frozen_string_literal: true

require "sinatra"

module WebTrap
  # Base class for creating fake web application to capture outgoing web
  # requests and assert on them.
  #
  # Descendants of this class are in charge of setting the required rules to
  # correctly intercept the target requests.
  #
  # Currently it is only used by SendRequestWithXml.
  class Server < Sinatra::Base
    @payload_was_valid = false
    @request_received = false

    class << self
      # Set whether the payload met the matcher constraints.
      # @param value [Boolean]
      attr_writer :payload_was_valid

      # Set whether a request was received at all.
      # @param value [Boolean]
      attr_writer :request_received
    end

    # Whether the payload met the matcher constraints.
    # @return [Boolean] `false` by default.
    def self.payload_was_valid?
      @payload_was_valid
    end

    # Whether a request was received at all.
    # @return [Boolean] `false` by default.
    def self.request_received?
      @request_received
    end
  end
end

# frozen_string_literal: true

module WebTrap
  module Rack
    class BaseApp
      @request_received = false

      class << self
        # Set whether a request was received at all.
        # @param value [Boolean]
        attr_writer :request_received
      end

      # Whether a request was received at all.
      # @return [Boolean] `false` by default.
      def self.request_received?
        @request_received
      end

      def self.call(_)
        @request_received = true

        [200, {}, [""]]
      end
    end
  end
end

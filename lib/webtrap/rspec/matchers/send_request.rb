# frozen_string_literal: true

require "webmock/rspec"

module WebTrap
  module RSpec
    module Matchers
      # @api private
      # Provides the implementation for `send_request`.
      # Not intended to be instantiated directly.
      class SendRequest
        # @api public
        # Specifies the XML payload of the request.
        #
        # The expectation will pass only if a request is sent with a payload
        # that is considered equivalent to the reference. For further details
        # see the {https://github.com/mbklein/equivalent-xml equivalent-xml}
        # gem.
        #
        # @param xml [] The reference XML payload.
        # @return [SendRequestWithXml]
        #   The matcher to verify that a request is with a payload equivalent
        #   to the reference.
        def with_xml(xml)
          SendRequestWithXml.new(xml)
        end

        # @api private
        # Checks if the provided Proc sends an HTTP request.
        # @param transmission_proc [Proc]
        #   The proc that should send an HTTP request.
        # @return
        #   Whether an HTTP request was sent.
        # @see {RSpec::Matchers::MatcherProtocol#matches?}
        def matches?(transmission_proc)
          perform_transmission(transmission_proc)
          request_sent?
        end

        # @api private
        # Message to be shown if the expectation fails to pass.
        # @return [String]
        def failure_message
          "expected block to send an HTTP request, but nothing was sent out"
        end

        # @api private
        # Allows the matcher to be used with block expectations.
        # @return [TrueClass]
        def supports_block_expectations?
          true
        end

        private

        def perform_transmission(transmission_proc)
          WebMock.disable_net_connect!
          begin
            transmission_proc.call
            @request_sent = false
          rescue WebMock::NetConnectNotAllowedError
            @request_sent = true
          end
          WebMock.allow_net_connect!
        end

        def request_sent?
          @request_sent
        end
      end
    end
  end
end

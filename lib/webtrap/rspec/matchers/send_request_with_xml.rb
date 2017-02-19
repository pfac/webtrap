# frozen_string_literal: true

require "equivalent-xml"
require "webmock/rspec"

module WebTrap
  module RSpec
    module Matchers
      # @api private
      # Used to specify the XML payload of the request.
      class SendRequestWithXml < SendRequest
        # Reference to be compared with the payload of outgoing XML requests.
        attr_reader :expected_payload

        # Allows the parameterization of the matcher with the reference payload.
        # @param expected_payload []
        #   Reference to be compared with the payload of outgoing XML requests.
        def initialize(expected_payload)
          @expected_payload = expected_payload
        end

        # @api private
        # Checks if the provided Proc sends a request with an XML payload
        # equivalent to the expected reference.
        # @param transmission_proc [Proc]
        #   The proc that should send a valid request.
        # @return
        #   Whether a request was sent with an equivalent XML payload.
        # @see {RSpec::Matchers::MatcherProtocol#matches?}
        def matches?(transmission_proc)
          perform_transmission(transmission_proc)
          request_sent? && valid_payload?
        end

        # @api private
        # Message to be shown if the expectation fails to pass.
        # @return [String]
        # @see {RSpec::Matchers::MatcherProtocol#failure_message}
        def failure_message
          return super unless request_sent?

          "expected block to send an HTTP request with XML body, but payload was not equivalent"
        end

        # @api private
        # Allows the matcher to be used with block expectations.
        # @return [TrueClass]
        # @see {RSpec::Matchers::MatcherProtocol#supports_block_expectations?}
        def supports_block_expectations?
          true
        end

        private

        def perform_transmission(transmission_proc)
          WebMock.disable_net_connect!
          WebMock::API.stub_request(:post, /.*/).to_rack(server)

          transmission_proc.call

          WebMock.allow_net_connect!
        end

        def server
          expected_payload = self.expected_payload

          @_server ||= ::Class.new(::WebTrap::Server) do
            @payload_was_valid = false
            @request_received = false

            post "*" do
              actual_payload = request.body.string

              self.class.request_received = true
              self.class.payload_was_valid = EquivalentXml.equivalent?(actual_payload, expected_payload)
            end
          end
        end

        def request_sent?
          super || server.request_received?
        end

        def valid_payload?
          server.payload_was_valid?
        end
      end
    end
  end
end

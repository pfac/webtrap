require "equivalent-xml"
require "webmock/rspec"

module Squealer
  module RSpec
    module Matchers
      class SendRequestWithXml < SendRequest
        attr_reader :expected_payload

        def initialize(expected_payload)
          @expected_payload = expected_payload
        end

        def matches?(transmission_proc)
          perform_transmission(transmission_proc)
          request_sent? && valid_payload?
        end

        def failure_message
          return super unless request_sent?

          "expected block to send an HTTP request with XML body, but payload was not equivalent"
        end

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

          @_server ||= ::Class.new(::Squealer::Server) do
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

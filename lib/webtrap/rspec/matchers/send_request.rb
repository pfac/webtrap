require "webmock/rspec"

module WebTrap
  module RSpec
    module Matchers
      class SendRequest
        def matches?(transmission_proc)
          perform_transmission(transmission_proc)
          request_sent?
        end

        def failure_message
          "expected block to send an HTTP request, but nothing was sent out"
        end

        def supports_block_expectations?
          true
        end

        def with_xml(xml)
          SendRequestWithXml.new(xml)
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

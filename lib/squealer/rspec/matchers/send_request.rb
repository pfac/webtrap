require "webmock/rspec"

module Squealer
  module RSpec
    module Matchers
      class SendRequest
        def matches?(transmission_proc)
          perform_transmission(transmission_proc)
          puts request_sent.inspect
          request_sent
        end

        def failure_message
          "expected block to send an HTTP request, but nothing was sent out"
        end

        def supports_block_expectations?
          true
        end

        private

        attr_reader :request_sent

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
      end
    end
  end
end

# frozen_string_literal: true

require "webtrap/rspec/matchers/send_request"
require "webtrap/rspec/matchers/send_request_with_xml"

module WebTrap
  module RSpec
    # WebTrap::RSpec::Matchers provides the set of matchers available to define
    # expections about outgoing requests.
    module Matchers
      # Passes if the block sends any HTTP request.
      #
      # @return [SendRequest]
      #   The matcher to verify that the request is sent.
      def send_request
        SendRequest.new
      end
    end
  end
end

RSpec.configure do |c|
  c.include WebTrap::RSpec::Matchers
end

# frozen_string_literal: true

module WebTrap
  module RSpec
    # WebTrap::RSpec::Matchers provides the set of matchers available to define
    # expections about outgoing requests.
    module Matchers
      autoload :SendRequest, "webtrap/rspec/matchers/send_request"

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

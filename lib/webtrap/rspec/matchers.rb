# frozen_string_literal: true

module WebTrap
  module RSpec
    # Set of matchers available to define expections about outgoing requests.
    module Matchers
      autoload :SendRequest, "webtrap/rspec/matchers/send_request"

      # Passes if the expectation block sends an HTTP request.
      #
      # Constraints to specify the expected request can be chained.
      #
      # @return [SendRequest]
      #   The matcher instance to verify that a request is sent.
      def send_request
        SendRequest.new
      end
    end
  end
end

RSpec.configure do |c|
  c.include WebTrap::RSpec::Matchers
end

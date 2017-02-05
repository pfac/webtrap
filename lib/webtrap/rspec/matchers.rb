require "webtrap/rspec/matchers/send_request"
require "webtrap/rspec/matchers/send_request_with_xml"

module WebTrap
  module RSpec
    module Matchers
      def send_request
        SendRequest.new
      end
    end
  end
end

RSpec.configure do |c|
  c.include WebTrap::RSpec::Matchers
end

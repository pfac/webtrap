require "squealer/rspec/matchers/send_request"
require "squealer/rspec/matchers/send_request_with_xml"

module Squealer
  module RSpec
    module Matchers
      def send_request
        SendRequest.new
      end
    end
  end
end

RSpec.configure do |c|
  c.include Squealer::RSpec::Matchers
end

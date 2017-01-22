require "squealer/rspec/matchers/send_request"

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

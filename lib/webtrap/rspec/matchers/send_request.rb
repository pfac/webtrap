# frozen_string_literal: true

require "webmock/rspec"
require "webtrap/shared"
require "rack"

module WebTrap
  module RSpec
    module Matchers
      # @api private
      # Provides the implementation for `send_request`.
      # Not intended to be instantiated directly.
      class SendRequest
        def initialize
          add_validator(Shared::Validators::RequestSentValidator.new)
        end

        # @api public
        # Specifies the XML payload of the request.
        #
        # The expectation will pass only if a request is sent with a payload
        # that is considered equivalent to the reference. For further details
        # see the {https://github.com/mbklein/equivalent-xml equivalent-xml}
        # gem.
        #
        # @param xml [] The reference XML payload.
        # @return [SendRequestWithXml]
        #   The matcher to verify that a request is with a payload equivalent
        #   to the reference.
        def with_xml(xml)
          add_validator(Shared::Validators::EquivalentXmlContentValidator.new(xml))
          self
        end

        # @api private
        # Checks if the provided Proc sends an HTTP request.
        # @param transmission_proc [Proc]
        #   The proc that should send an HTTP request.
        # @return
        #   Whether an HTTP request was sent.
        # @see {RSpec::Matchers::MatcherProtocol#matches?}
        def matches?(transmission_proc)
          perform_transmission(transmission_proc)
          failure_message.nil?
        end

        # @api private
        # Message to be shown if the expectation fails to pass.
        # @return [String]
        def failure_message
          failed_validator&.message
        end

        # @api private
        # Allows the matcher to be used with block expectations.
        # @return [TrueClass]
        def supports_block_expectations?
          true
        end

        private

        def validators
          @_validators ||= []
        end

        def add_validator(validator)
          validators << validator
        end

        def failed_validator
          validators.find(&:failed?)
        end

        def perform_transmission(transmission_proc)
          WebMock.disable_net_connect!
          WebMock::API.stub_request(:any, /.*/).to_rack(app)

          transmission_proc.call

          WebMock.allow_net_connect!
        end

        def app
          @_app ||= Shared::MockAppGenerator.generate(validators)
        end
      end
    end
  end
end

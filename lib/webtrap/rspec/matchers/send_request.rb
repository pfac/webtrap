# frozen_string_literal: true

require "webmock/rspec"
require "webtrap/shared"
require "rack"

module WebTrap
  module RSpec
    module Matchers
      # @api private
      # Provides the implementation for <code>send_request</code>.
      #
      # Not intended to be instantiated directly.
      #
      # @see http://www.rubydoc.info/github/rspec/rspec-expectations/RSpec/Matchers/MatcherProtocol RSpec Matcher Protocol
      class SendRequest
        # Initialize a new matcher.
        #
        # Unless more constraints are chained, this matcher will pass as long
        # as any HTTP request gets intercepted.
        #
        # @see Shared::Validators::RequestSentValidator
        def initialize
          add_validator(Shared::Validators::RequestSentValidator.new)
        end

        # @api public
        # Specifies the XML payload of the request.
        #
        # The expectation will pass only if a request is sent with a payload
        # that is considered equivalent to the reference.
        #
        # @param xml [String]
        #   The reference XML payload.
        # @return [SendRequest]
        #   This matcher instance, to allow further chaining.
        # @see Shared::Validators::EquivalentXmlContentValidator
        def with_xml(xml)
          add_validator(Shared::Validators::EquivalentXmlContentValidator.new(xml))
          self
        end

        # @api private
        # Whether a request was intercepted that matches all validators.
        #
        # Executes the provided proc, intercepting all transmitted HTTP requests
        # and running them through the set of validators.
        #
        # @param transmission_proc [Proc]
        #   The proc that is expected to send the requests.
        # @return {Boolean}
        def matches?(transmission_proc)
          perform_transmission(transmission_proc)
          failure_message.nil?
        end

        # @api private
        # Message to be shown if no request is intercepted for which all
        # validators are successful.
        #
        # @return [String]
        def failure_message
          return if failed_validator.nil?
          failed_validator.failure_message
        end

        # @api private
        # Allows the matcher to be used with block expectations.
        #
        # @return [true]
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
          @_app ||= Shared::RackApp.new(validators)
        end
      end
    end
  end
end

# frozen_string_literal: true

require "equivalent-xml"

# @api private
# Validator for asserting a request was sent with an equivalent XML payload.
#
# @see https://github.com/mbklein/equivalent-xml
#   equivalent-xml gem
class WebTrap::Shared::Validators::EquivalentXmlContentValidator
  # Instantiate a new validator with the provided payload.
  #
  # @param xml [String]
  #   The XML payload requests will be compared against.
  def initialize(xml)
    @failed = true
    @xml = xml
  end

  # Whether no request with an equivalent payload was validated.
  #
  # @return [Boolean]
  def failed?
    @failed
  end

  # The message to be used if no request is validated with an equivalent
  # payload.
  #
  # @return [String]
  def failure_message
    "expected block to send an HTTP request with XML body, but payload was not equivalent"
  end

  # Validate if the request has an equivalent XML payload.
  #
  # @param request [Hash]
  #   Request environment passed by {WebTrap::Shared::RackApp#call}.
  # @return [EquivalentXmlContentValidator]
  #   This validator instance.
  def validate(request)
    @failed = EquivalentXml.equivalent?(xml, request["rack.input"].string)
    self
  end

  private

  attr_reader :xml
end

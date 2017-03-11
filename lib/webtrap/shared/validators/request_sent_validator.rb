# frozen_string_literal: true

# @api private
# Validator for asserting whether a request was sent.
class WebTrap::Shared::Validators::RequestSentValidator
  # Initialize a new validator.
  def initialize
    @failed = true
  end

  # Whether no request was validated.
  #
  # @return [Boolean]
  def failed?
    @failed
  end

  # The message to be used if no request is validated.
  #
  # @return [String]
  def failure_message
    "expected block to send an HTTP request, but nothing was sent out"
  end


  # Validate a request.
  #
  # Since validators are run against intercepted requests this validator will
  # succeed for any request.
  #
  # @return [RequestSentValidator]
  #   This validator instance.
  def validate(_)
    @failed = false
    self
  end
end

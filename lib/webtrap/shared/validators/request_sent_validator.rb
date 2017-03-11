# frozen_string_literal: true

# @api private
class WebTrap::Shared::Validators::RequestSentValidator
  def initialize
    @failed = true
  end

  def failed?
    @failed
  end

  def validate(_)
    @failed = false
    self
  end

  def message
    "expected block to send an HTTP request, but nothing was sent out"
  end
end

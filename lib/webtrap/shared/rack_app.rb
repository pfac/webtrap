# frozen_string_literal: true

class WebTrap::Shared::RackApp
  def initialize(validators)
    @validators = validators
  end

  def call(request)
    @validators.find do |v|
      v.validate(request).failed?
    end
    [200, {}, []]
  end
end

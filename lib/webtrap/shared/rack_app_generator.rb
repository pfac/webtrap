# frozen_string_literal: true

class WebTrap::Shared::RackAppGenerator
  def self.generate(validators)
    Class.new(RackApp) do
      @validators = validators
    end
  end

  private

  class RackApp
    def self.call(request)
      @validators.find do |v|
        v.validate(request).failed?
      end
      response
    end

    def self.response
      [200, {}, []]
    end
  end
end

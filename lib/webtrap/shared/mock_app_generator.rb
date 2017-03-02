# frozen_string_literal: true

class WebTrap::Shared::MockAppGenerator
  def self.generate(validators)
    Class.new(MockApp) do
      @validators = validators
    end
  end

  private

  class MockApp
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

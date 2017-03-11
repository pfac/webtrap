# frozen_string_literal: true

# @api private
# Rack applications used to intercept HTTP requests and apply a set of
# validators on them.
class WebTrap::Shared::RackApp
  # Instantiate a new Rack application with the provided set of validators.
  #
  # @param validators [Array]
  #   Set of validators used on the intercepted request to assert its validity.
  # @example Intercept any request
  #   require "webmock"
  #   # ...
  #   WebMock::API.stub_request(:any, /.*/).to_rack RackApp.new(validators)
  def initialize(validators)
    @validators = validators
  end

  # Handle an HTTP request.
  #
  # @param request [Hash]
  #   Request environment, as defined by the Rack spec.
  # @return [Array<Fixnum, Hash, Array>]
  #   An empty successful response.
  # @see http://www.rubydoc.info/github/rack/rack/master/file/SPEC
  #   Rack spec
  def call(request)
    @validators.find do |v|
      v.validate(request).failed?
    end
    [200, {}, []]
  end
end

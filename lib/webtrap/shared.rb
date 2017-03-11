# frozen_string_literal: true

require "webtrap/shared/validators"

module WebTrap
  # @api private
  # Shared components used by all implementations for specific testing tools.
  module Shared
    autoload :RackApp, "webtrap/shared/rack_app"
  end
end

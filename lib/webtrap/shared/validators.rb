# frozen_string_literal: true

module WebTrap
  module Shared
    # @api private
    # Validators used to assert constraints over the intercepted HTTP requests.
    module Validators
      autoload :EquivalentXmlContentValidator, "webtrap/shared/validators/equivalent_xml_content_validator"
      autoload :RequestSentValidator, "webtrap/shared/validators/request_sent_validator"
    end
  end
end

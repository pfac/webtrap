require "equivalent-xml"

class WebTrap::Shared::Validators::EquivalentXmlContentValidator
  def initialize(xml)
    @failed = true
    @xml = xml
  end

  def failed?
    @failed
  end

  def validate(request)
    @failed = EquivalentXml.equivalent?(xml, request["rack.input"].string)
    self
  end

  def message
    "expected block to send an HTTP request with XML body, but payload was not equivalent"
  end

  private

  attr_reader :xml
end

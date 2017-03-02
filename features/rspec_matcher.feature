Feature: RSpec matcher

  Scenario: expect{...}.to send_request
    Given a spec file with:
      """ruby
      require "webtrap/rspec"
      require "net/http"

      RSpec.describe Net::HTTP, "#get" do
        it "should send a request" do
          expect do
            Net::HTTP.get("example.com", "/")
          end.to send_request
        end

        # deliberate failure
        it "should send a request" do
          expect{}.to send_request
        end
      end
      """
    When I run `rspec <path_to_file>`
    Then the output should contain "1 failure"
     And the output should contain "expected block to send an HTTP request, but nothing was sent out"

  Scenario: expect{...}.to send_request.with_xml(...)
    Given a spec file with:
      """ruby
      require "webtrap/rspec"
      require "net/http"

      RSpec.describe Net::HTTP, "#get" do
        let :xml do
          <<-EOS
            <?xml version="1.0" encoding="utf-8"?>
            <root></root>
          EOS
        end

        it "should send a request" do
          expect do
            request = Net::HTTP::Post.new "/"
            request.body = xml
            request.content_type = "text/xml"

            http = Net::HTTP.new("example.com")
            http.request(request)
          end.to send_request.with_xml(xml)
        end

        # deliberate failures
        it "should send a request" do
          expect{}.to send_request.with_xml(xml)
        end
        it "should send a request" do
          expect do
            Net::HTTP.post_form(URI("http://example.com/"), {})
          end.to send_request.with_xml(xml)
        end
      end
      """
    When I run `rspec <path_to_file>`
    Then the output should contain "2 failures"
     And the output should contain "expected block to send an HTTP request, but nothing was sent out"
     And the output should contain "expected block to send an HTTP request with XML body, but payload was not equivalent"

Feature: RSpec matcher

  Scenario: send_request matcher
    Given a spec file with:
      """ruby
      require "squealer/rspec"

      RSpec.describe Net::HTTP, "#get" do
        it "should send a request" do
          expect do
            Net::HTTP.get("example.com", "/")
          end.to send_request
        end

        # deliberate failure
        it "should send another request" do
          expect{}.to send_request
        end
      end
      """
    When I run `rspec <path_to_file>`
    Then the output should contain "1 failure"
     And the output should contain "expected block to send an HTTP request, but nothing was sent out"


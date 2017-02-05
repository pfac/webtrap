require "tempfile"

After do
  @file.unlink
end

Given(/^a spec file with:$/) do |content|
  @file = Tempfile.new("webtrap")
  begin
    @file.write content
  ensure
    @file.close
  end
end

When(/^I run `rspec <path_to_file>`$/) do
  @output = `bundle exec rspec #{@file.path}`
end

Then(/^the output should contain "([^"]*)"$/) do |string|
  expect(@output).to include string
end

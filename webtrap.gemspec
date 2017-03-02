# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "webtrap/version"

Gem::Specification.new do |spec|
  spec.name          = "webtrap"
  spec.version       = WebTrap::VERSION
  spec.authors       = ["Pedro Costa"]
  spec.email         = ["pedro@subvisual.co"]

  spec.summary       = %(Test your outgoing requests.)
  spec.description   = <<-EOS
    WebTrap allows you to write tests that assert on outgoing requests. This
    allows you to verify that such requests match the documentation of external
    services without actually having to hit them.
  EOS
  spec.homepage      = "https://github.com/pfac/webtrap"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise <<-EOS
      RubyGems 2.0 or newer is required to protect against public gem pushes.
    EOS
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "equivalent-xml", "~> 0.6.0"
  spec.add_dependency "rack", "~> 1.0"
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "webmock", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "cucumber", "~> 2.0"
  spec.add_development_dependency "pry-remote", "~> 0.1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop", "~> 0.47.1"
end

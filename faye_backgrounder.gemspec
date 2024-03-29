# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faye_backgrounder/version'

Gem::Specification.new do |spec|
  spec.name          = "faye_backgrounder"
  spec.version       = FayeBackgrounder::VERSION
  spec.authors       = ["Jason Truluck"]
  spec.email         = ["jason.truluck@gmail.com"]
  spec.description   = %q{Publish updates to the client side from your background workers via Faye}
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

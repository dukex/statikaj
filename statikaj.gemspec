# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'statikaj/version'

Gem::Specification.new do |spec|
  spec.name          = "statikaj"
  spec.version       = Statikaj::VERSION
  spec.authors       = ["Duke"]
  spec.email         = ["duke@riseup.net"]
  spec.description   = %q{Statikaj is simple tool to create statikaj blogs.}
  spec.summary       = %q{Statikaj is simple tool to create statikaj blogs.}
  spec.homepage      = "https://github.com/dukex/statikaj"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "kramdown"
  spec.add_dependency "thor"
  spec.add_dependency "builder"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gtfs/data_exchange/version'

Gem::Specification.new do |spec|
  spec.name          = "gtfs-data_exchange"
  spec.version       = GTFS::DataExchange::VERSION
  spec.authors       = ["MJ Rossetti (@s2t2)"]
  spec.email         = ["s2t2mail@gmail.com"]
  spec.summary       = %q{A ruby wrapper for the gtfs-data-exchange.com api.}
  spec.description   = %q{A ruby wrapper for the gtfs-data-exchange.com api. List all agencies, or find a specific agency by its data exchange identifier.}
  spec.homepage      = "https://github.com/data-creative/gtfs-data-exchange-api-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_dependency "httparty", "~> 0.13"
end

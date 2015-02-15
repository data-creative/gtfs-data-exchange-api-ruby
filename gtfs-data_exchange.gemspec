# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gtfs/data_exchange/version'

Gem::Specification.new do |spec|
  spec.name          = "gtfs-data_exchange"
  spec.version       = GTFS::DataExchange::VERSION
  spec.authors       = ["MJ Rossetti (@s2t2)"]
  spec.email         = ["s2t2mail+rubygems@gmail.com"]
  spec.summary       = %q{This gem has been renamed from *gtfs-data_exchange* to *gtfs_data_exchange_api*.}
  spec.description   = %q{This gem has been renamed from *gtfs-data_exchange* to *gtfs_data_exchange_api*. See https://rubygems.org/gems/gtfs_data_exchange_api for the current version.}
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

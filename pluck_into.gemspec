# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pluck_into/version'

Gem::Specification.new do |spec|
  spec.name          = "pluck_into"
  spec.version       = PluckInto::VERSION
  spec.authors       = ["Kyle Hargraves"]
  spec.email         = ["pd@krh.me"]

  spec.summary       = %q{Like ActiveRecord::Base#pluck, producing your choice of PORO}
  spec.description   = %q{Limit what you query, but still get an object type of your choosing}
  spec.homepage      = "https://github.com/pd/pluck_into"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", "> 0"
end

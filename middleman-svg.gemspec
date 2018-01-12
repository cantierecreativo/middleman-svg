# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/svg/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-svg"
  spec.version       = Middleman::Svg::VERSION
  spec.authors       = ["Damiano Giacomello"]
  spec.email         = ["d.giacomello@cantierecreativo.net"]

  spec.summary       = "A simple helper to generate inline SVG with Middleman"
  spec.description   = "A simple helper to generate inline SVG content with Middleman"
  spec.homepage      = "https://github.com/cantierecreativo/middleman-svg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "middleman-core", ">= 4.0.0"
  spec.add_runtime_dependency "activesupport", ">= 3.0"
  spec.add_runtime_dependency "nokogiri", ">= 1.6"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-svg/version'

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = "middleman-svg"
  s.version       = Middleman::Svg::VERSION
  s.authors       = ["Damiano Giacomello"]
  s.email         = ["giacomello.damiano@gmail.com"]

  s.summary       = "A simple helper to generate inline SVG with Middleman"
  s.description   = "A simple helper to generate inline SVG content with Middleman"
  s.homepage      = "https://github.com/cantierecreativo/middleman-svg"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'middleman-core', '~> 4.0', '>= 4.0.0'
  s.add_runtime_dependency "activesupport", ['>= 4.2', '< 5.2']
  s.add_runtime_dependency "nokogiri", "~> 1.6", ">= 1.6"
end

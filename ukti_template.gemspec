# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ukti_template/version'

Gem::Specification.new do |spec|
  spec.name          = "ukti_template"
  spec.version       = UktiTemplate::VERSION
  spec.authors       = ["Joshua Marshall"]
  spec.email         = ["joshua@workwithgreat.com"]
  spec.summary       = %q{Rails engine supplying the UKTI EIG front-end assets}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/dxw/ukti_template"
  spec.license       = "MIT"

  spec.files         = Dir["{app,lib}/**/*"] + ["LICENCE.txt", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 5.0.0"

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'sprockets', '3.6.3'
  spec.add_development_dependency 'sass', '~> 3.4.22'
  spec.add_development_dependency 'gem_publisher', '1.5.0'
  spec.add_development_dependency 'rspec', '3.5.0'
  spec.add_development_dependency 'rspec-html-matchers', '0.8.0'
  spec.add_development_dependency 'mustache', '1.0.3'
  spec.add_development_dependency 'nokogiri', '1.6.8'
  spec.add_development_dependency 'octokit', '3.4.2'
  spec.add_development_dependency 'pry'
end

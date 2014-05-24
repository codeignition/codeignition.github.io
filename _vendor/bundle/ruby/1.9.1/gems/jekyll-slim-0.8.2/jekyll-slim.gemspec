# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-slim/version'

Gem::Specification.new do |gem|
  gem.name          = "jekyll-slim"
  gem.version       = Jekyll::Slim::VERSION
  gem.authors       = ["Reda Lemeden"]
  gem.email         = ["reda@thoughtbot.com"]
  gem.description   = %q{Slim html converter for Jekyll}
  gem.summary       = %q{Slim-lang support for Jekyll. Handles includes and layouts as well.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'jekyll', ">= 0.10.0"
  gem.add_runtime_dependency 'slim'

  gem.add_development_dependency('rake')
  gem.add_development_dependency('bundler')
  gem.add_development_dependency('rspec')
end

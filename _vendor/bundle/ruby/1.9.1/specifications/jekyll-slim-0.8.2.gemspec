# -*- encoding: utf-8 -*-
# stub: jekyll-slim 0.8.2 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-slim"
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Reda Lemeden"]
  s.date = "2013-05-06"
  s.description = "Slim html converter for Jekyll"
  s.email = ["reda@thoughtbot.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.10"
  s.summary = "Slim-lang support for Jekyll. Handles includes and layouts as well."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>, [">= 0.10.0"])
      s.add_runtime_dependency(%q<slim>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<jekyll>, [">= 0.10.0"])
      s.add_dependency(%q<slim>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<jekyll>, [">= 0.10.0"])
    s.add_dependency(%q<slim>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

require 'slim'
require 'jekyll-slim/version'
require 'jekyll-slim/tags/slim_partial'
require 'jekyll-slim/ext/layout'

module Jekyll
  class SlimConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /slim/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      begin
        ::Slim::Template.new { content }.render
      rescue StandardError => e
        puts "(!) SLIM ERROR: " + e.message
      end
    end
  end
end

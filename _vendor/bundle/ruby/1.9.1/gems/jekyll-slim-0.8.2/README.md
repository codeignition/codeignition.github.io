# Jekyll-slim

[![Gem Version](https://badge.fury.io/rb/jekyll-slim.png)](http://badge.fury.io/rb/jekyll-slim) [![Dependency Status](https://gemnasium.com/kaishin/jekyll-slim.png)](https://gemnasium.com/kaishin/jekyll-slim) [![Code Climate](https://codeclimate.com/github/kaishin/jekyll-slim.png)](https://codeclimate.com/github/kaishin/jekyll-slim) [![Build Status](https://travis-ci.org/kaishin/jekyll-slim.png)](https://travis-ci.org/kaishin/jekyll-slim)

A gem that adds [slim-lang](http://slim-lang.com) support to [Jekyll](http://github.com/mojombo/jekyll). Works for for pages, includes and layouts.

## Installation

Add this line to your Gemfile:

    gem 'jekyll-slim'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-slim

In your Jekyll project's `_plugins` directory:

    # _plugins/bundler.rb
    require 'rubygems'
    require 'bundler/setup'
    Bundler.require(:default)

## Usage

The gem will convert all the `.slim` files in your project's directory into HTML. That includes files in sub-directories, includes and layouts. Example:

```haml
# _layouts/default.slim
html
  head
  body
    .content-wrapper
      | {{ content }}
```
To include a partial, use the `slim` liquid tag instead of `include`:

```haml
# index.slim
---
layout: default
---

section.content Content goes here.
| {% slim footer.slim %}

```

## Credit

Jekyll-slim was heavily inspired by [jekyll-haml](https://github.com/samvincent/jekyll-haml). It is free software, and may be redistributed under the terms specified in the LICENSE file.


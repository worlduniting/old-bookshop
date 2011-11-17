# -*- encoding: utf-8 -*-
require File.expand_path("../lib/bookshop/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "bookshop"
  s.version     = Bookshop::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['D.a. Thompson']
  s.email       = ['git@worlduniting.org']
  s.homepage    = "http://rubygems.org/gems/bookshop"
  s.summary     = "A publishing framework for html-to-(e)book toolchain happiness and sustainable productivity."
  s.description = "bookShop is a publishing framework for html-to-(e)book toolchain happiness and sustainable productivity. 
                    The framework is optimized to help developers quickly ramp-up, allowing them to more rapidly 
                    jump in and develop their html-to-(e)book (print-pdf, epub, mobi, etc.) flows, by favoring convention over 
                    configuration, setting them up with best practices, standards and tools from the start."
  s.license     = "MIT"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "bookshop"
  s.has_rdoc = true

  
  s.add_dependency "thor", ">= 0.14.6"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
require File.expand_path("../lib/bookshop/version", __FILE__)
require File.expand_path("../lib/bookshop/post_install", __FILE__)

Gem::Specification.new do |s|
  s.name        = "bookshop"
  s.version     = Bookshop::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Dave Thompson'
  s.email       = 'dave@blueheadpublishing.com'
  s.homepage    = 'http://blueheadpublishing.com/products/bookshop/'
  s.summary     = 'An agile book publishing framework for building pdf/(e)books based on HTML5, CSS, and JavaScript.'
  s.description = 'bookshop is an agile book publishing framework for building pdf/(e)books based on HTML5,
                    CSS, and JavaScript. The framework is optimized to help publishers, editors, and authors
                    quickly ramp-up, allowing them to jump in and develop their html-to-pdf/(e)book flows by
                    favoring convention over configuration, setting them up with best-practices, standards
                    and tools from the start.'
  s.license     = 'MIT'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'bookshop'
  s.has_rdoc = true

  s.files        = Dir['CHANGELOG.mc', 'README.rdoc', 'bin/**/*', 'lib/**/{*,.[a-z]*}']
  s.require_path = 'lib'
  
  s.bindir       = 'bin'
  s.executables  = ['bookshop']
  
  s.add_dependency 'thor', '>= 0.14.6'
  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'mocha'
  
  s.post_install_message = Bookshop::POST_INSTALL
end
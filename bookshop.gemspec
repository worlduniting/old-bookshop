require File.expand_path("../lib/bookshop/version", __FILE__)
require File.expand_path("../lib/bookshop/post_install", __FILE__)

Gem::Specification.new do |s|
  s.name        = "bookshop"
  s.version     = Bookshop::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'D.a. Thompson'
  s.email       = 'da@blueheadpublishing.com'
  s.homepage    = 'http://rubygems.org/gems/bookshop'
  s.summary     = 'A publishing framework for html-to-pdf/(e)book toolchain happiness and sustainable productivity.'
  s.description = 'bookShop is a publishing framework for html-to-pdf/(e)book toolchain happiness and sustainable productivity. 
                    The framework is optimized to help developers quickly ramp-up, allowing them to more rapidly 
                    jump in and develop their html-to-pdf/(e)book (print-pdf, epub, mobi, etc.) flows, by favoring convention over 
                    configuration, setting them up with best practices, standards and tools from the start.'
  s.license     = 'MIT'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'bookshop'
  s.has_rdoc = true

  s.files        = Dir['CHANGELOG', 'README.rdoc', 'bin/**/*', 'lib/**/{*,.[a-z]*}']
  s.require_path = 'lib'
  
  s.bindir       = 'bin'
  s.executables  = ['bookshop']
  
  s.add_dependency 'thor', '>= 0.14.6'
  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rdoc'
  
  s.post_install_message = Bookshop::POST_INSTALL
end
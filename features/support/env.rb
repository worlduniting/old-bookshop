$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec/expectations'

Before do
  # @dirs = ["/tmp/aruba"]
  # raise timeouts
  # @aruba_timeout_seconds = 5
  @aruba_io_wait_seconds = 8
end
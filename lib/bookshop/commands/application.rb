require 'bookshop/version'
if %w(--version -v).include? ARGV.first
  puts "Bookshop #{Bookshop::VERSION}"
  exit(0)
end

if ARGV.first != "new"
  ARGV[0] = "--help"
else
  ARGV.shift
end

require 'rubygems' if ARGV.include?("--dev")

require 'bookshop/generators/bookshop/app/app_generator'

Bookshop::Generators::AppGenerator.start
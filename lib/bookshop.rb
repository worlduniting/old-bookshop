require 'rbconfig'
require 'bookshop/error'
require 'bookshop/script_bookshop_loader'

# If we are inside a Bookshop project this method performs an exec and thus
# the rest of this script is not run.
Bookshop::ScriptBookshopLoader.exec_script_bookshop!

bookshop_path = File.expand_path('../../lib', __FILE__)
$:.unshift(bookshop_path) if File.directory?(bookshop_path) && !$:.include?(bookshop_path)

require 'bookshop/ruby_version_check'
Signal.trap("INT") { puts; exit }
begin
require 'bookshop/commands/application'
rescue Bookshop::Error => e
  puts e.message
end

ARGV << '--help' if ARGV.empty?

aliases = {
  "b"  => "build"
}

command = ARGV.shift
command = aliases[command] || command

case command
when 'build'
  require 'bookshop/commands/build'

when 'new'
  puts "Can't create a new Bookshop application within the directory of another, please change to a non-Bookshop directory first.\n"
  puts "Type 'bookshop' for help."

else
  puts "Error: Command not recognized" unless %w(-h --help).include?(command)
  puts <<-EOT
Usage: bookshop COMMAND [ARGS]

The most common bookshop commands are:
 build       Builds a new book from your html based upon arguments passed (short-cut alias: "b")
 new         Create a new bookshop project. "bookshop new name_of_book" creates a
             new book project called NameOfBook in "./name_of_book"

All commands can be run with -h for more information.
  EOT
end

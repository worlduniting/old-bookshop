require 'thor/group'

module Bookshop
  module Commands
    # Define build commands for bookshop command line
    class Build < Thor::Group
      include Thor::Actions
      
      ARGV << '--help' if ARGV.empty?

      aliases = {
        "p"  => "pdf"
      }

      build = ARGV.shift
      build = aliases[build] || build

      # Define arguments and options
      argument :type,                   :type => :string

      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end
      
      
      case build
      
      # 'build pdf' creates a pdf of the book
      when 'pdf'
        puts "Deleting any old builds"
        File.delete("builds/pdf/book.pdf") if File::exists?( "builds/pdf/book.pdf" )
        puts "File Deleted"
        puts "Building new pdf at builds/pdf/book.pdf"
        cmd = %x[wkhtmltopdf book/book.html builds/pdf/book.pdf]
        # cmd = %x[wkhtmltopdf #{SRC_FILE} #{OUT_FILE}]
        
      else
        puts "Error: Command not recognized" unless %w(-h --help).include?(build)
        puts <<-EOT
      Usage: bookshop build [ARGS]

      The most common build commands are:
       pdf          Builds a new pdf at /builds/pdf/book.pdf
       epub         Builds a new epub at /builds/epub/book.epub
       html         Builds a new html at /builds/html/book.html
       all          Builds all possible builds in their respective locations

      All commands can be run with -h for more information.
        EOT
      end
    end
  end
end

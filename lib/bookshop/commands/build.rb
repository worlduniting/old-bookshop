require 'thor/group'
require 'erb'

# find a way to use css

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
      
      erb = ERB.new(File.read('book/book.html.erb'))

      # Define arguments and options
      argument :type,                   :type => :string

      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end
      
      case build
      
      # 'build html' creates a html version of the book
      when 'html'
        puts "Deleting any old builds"
        File.delete("builds/html/book.html") if File::exists?( "builds/html/book.html" )
        puts "Building new html at builds/html/book.html from erb"
        File.open('builds/html/book.html', 'a') do |f|
          f << erb.result
        end

        # Copy book css to the html build dir
        def copy_css_to_html_build
          directory "book/css/", "builds/html/css/"
        end
        
      # 'build pdf' creates a pdf version of the book
      when 'pdf'      
        puts "Deleting any old builds"
        File.delete("builds/pdf/book.pdf") if File::exists?( "builds/pdf/book.pdf" )
        File.delete("builds/html/book.html") if File::exists?( "builds/html/book.html" )
        puts "Generating new html from erb"
        File.open('builds/html/book.html', 'a') do |f|
          f << erb.result
        end
        
        # Copy book css to the html build dir
        def copy_css_to_html_build
          directory "book/css/", "builds/html/css/"
        end
        
        puts "Building new pdf at builds/pdf/book.pdf from new html build"
        cmd = %x[wkhtmltopdf builds/html/book.html builds/pdf/book.pdf]
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

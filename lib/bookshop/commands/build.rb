require 'thor/group'
require 'erb'
require 'fileutils'
require 'pdfkit'

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
      argument :type

      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end
      
      case build
      
      # 'build html' creates a html version of the book
      when 'html'
        # Clean up any old builds
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/html/*')
        
        puts "Generating new html from erb"
        File.open('builds/html/book.html', 'a') do |f|
          f << erb.result
        end
        
        FileUtils.cp_r('book/css/', 'builds/html/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/html/', :verbose => true)
        
      # 'build pdf' creates a pdf version of the book
      when 'pdf'
        # Clean up any old builds
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/pdf/*')
        FileUtils.rm_r Dir.glob('builds/html/*')
        
        # Generate the html from ERB
        puts "Generating new html from erb"
        File.open('builds/html/book.html', 'a') do |f|
          f << erb.result
        end

        # Copy over html assets
        FileUtils.cp_r('book/css/', 'builds/html/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/html/', :verbose => true)

        # Build the pdf
        puts "Building new pdf at builds/pdf/book.pdf from new html build"
        # cmd = %x[wkhtmltopdf builds/html/book.html builds/pdf/book.pdf]
        
        
        kit = PDFKit.new(File.new('builds/html/book.html'))
        kit.stylesheets << 'builds/html/css/stylesheet.css'

        # Git an inline PDF
        pdf = kit.to_pdf

        # Save the PDF to a file
        file = kit.to_file('builds/pdf/book.pdf')
        
      else
        puts "Error: Command not recognized" unless %w(-h --help).include?(build)
        puts <<-EOT
      Usage: bookshop build [ARGS]

      The most common build commands are:
       pdf          Builds a new pdf at /builds/pdf/book.pdf
       html         Builds a new html at /builds/html/book.html

      All commands can be run with -h for more information.
        EOT
      end
    end
  end
end

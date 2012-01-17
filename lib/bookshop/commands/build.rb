require 'thor/group'
require 'erb'
require 'fileutils'
require 'yaml'
require 'PDFKit'

require 'bookshop/commands/yaml/book'

# require 'bookshop/commands/yaml/toc'
# require 'bookshop/commands/epub/epub_build'

module Bookshop
  module Commands

    # Define build commands for bookshop command line
    class Build < Thor::Group
      include Thor::Actions
      
      BOOK_SOURCE = 'book.html.erb'
      
      def initialize
        @book = []
      end
      
      ARGV << '--help' if ARGV.empty?

      aliases = {
        "p"  => "pdf"
      }

      build = ARGV.shift
      build = aliases[build] || build
      

      # Define arguments and options
      argument :type
      class_option :test_framework, :default => :test_unit

      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end

      # Load YAML files
      def self.load_yaml_files
        # Load the book.yml into the Book object
        @book = Book.new(YAML.load_file('config/book.yml'))
        # @toc = Toc.new(YAML.load_file('config/toc.yml'))
      end

      # Renders <%= import(source.html.erb) %> files with ERB
      # 
      # When a new import() is encountered within source files it is
      #    processed with this method and the result is added to 'erb'
      def self.import(file)
        load_yaml_files
        # Parse the source erb file
        ERB.new(File.read('book/'+file)).result(binding).gsub(/\n$/,'')
      end

      case build
      
      # 'build html' generates a html version of the book from the
      #    book/book.html.erb source file
      # @output variable is set to "html" for access as a conditional
      #   in the source erb's
      when 'html'
        # Clean up any old builds
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/html/*')
        
        @output = :html
        erb = import(BOOK_SOURCE)
        puts "Generating new html from erb"
        File.open("builds/html/book.html", 'a') do |f|
          f << erb
        end
        
        FileUtils.cp_r('book/css/', 'builds/html/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/html/', :verbose => true)
        
      # 'build pdf' generates a pdf version of the book from the builds/html/book.html
      #    which is generated from the book/book.html.erb source file
      when 'pdf'
        
        # Clean up any old builds
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/pdf/*')
        FileUtils.rm_r Dir.glob('builds/html/*')
        
        @output = :pdf
        erb = import(BOOK_SOURCE)
        # Generate the html from ERB
        puts "Generating new html from erb"
        File.open('builds/html/book.html', 'a') do |f|
          f << erb
        end

        # Copy over html assets
        FileUtils.cp_r('book/css/', 'builds/html/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/html/', :verbose => true)


        # PDFKit.new takes the HTML and any options for wkhtmltopdf
        # run `wkhtmltopdf --extended-help` for a full list of options
        kit = PDFKit.new(File.new('builds/html/book.html'))

        # Git an inline PDF
        pdf = kit.to_pdf

        # Save the PDF to a file
        file = kit.to_file('builds/pdf/book.pdf')
        
      when 'epub'
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/epub/*')
        FileUtils.rm_r Dir.glob('builds/html/*')

        
        @output = :epub

        erb = import(BOOK_SOURCE)

        # Generate the html from ERB
        puts "Building new html at builds/epub/OEBPS/book.html"
        
        empty_directory "OEBPS"
        
        File.open('builds/epub/OEBPS/book.html', 'a') do |f|
          f << erb
        end
        FileUtils.cp_r('book/css/', 'builds/epub/OEBPS/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/epub/OEBPS/', :verbose => true)

        # open content.opf.tt just like for html erb

        # zip the contents into book.epub

        # cmd = %x[tools/epubcheck book_#{Time.now.strftime('%m-%e-%y').epub]

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

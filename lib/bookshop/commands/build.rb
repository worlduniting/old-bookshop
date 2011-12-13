require 'thor/group'
require 'erb'
require 'fileutils'
require 'yaml'

module Bookshop
  module Commands
    
    class Book

      def initialize(data={})
        @data = {}
        update!(data)
      end

      def update!(data)
        data.each do |key, value|
          self[key] = value
        end
      end

      def [](key)
        @data[key.to_sym]
      end

      def []=(key, value)
        if value.class == Hash
          @data[key.to_sym] = Book.new(value)
        else
          @data[key.to_sym] = value
        end
      end

      def method_missing(sym, *args)
        if sym.to_s =~ /(.+)=$/
          self[$1] = args.first
        else
          self[sym]
        end
      end

    end
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
      argument :type

      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end

      # Renders <%= import(source.html.erb) %> files with ERB
      # 
      # When a new import() is encountered within source files it is
      #    processed with this method and the result is added to 'erb'
      def self.import(file)
        # Load book settings into the book object
        book = Book.new(YAML.load_file('config/book.yml'))
        ERB.new(File.read('book/'+file)).result(binding).gsub(/\n$/,'')
      end
      
      erb = import('book.html.erb')
      
      case build
      
      # 'build html' generates a html version of the book from the
      #    book/book.html.erb source file
      when 'html'
        # Clean up any old builds
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/html/*')
        
        puts "Generating new html from erb"
        File.open("builds/html/book_#{Time.now.strftime('%m-%e-%y')}.html", 'a') do |f|
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
        
        # Generate the html from ERB
        puts "Generating new html from erb"
        File.open('builds/html/book.html', 'a') do |f|
          f << erb
        end

        # Copy over html assets
        FileUtils.cp_r('book/css/', 'builds/html/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/html/', :verbose => true)

        # Builds the pdf from builds/html/book.html
        puts "Building new pdf at builds/pdf/book.pdf from new html build"
        cmd = %x[wkhtmltopdf builds/html/book.html builds/pdf/book_#{Time.now.strftime('%m-%e-%y')}.pdf]
        
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

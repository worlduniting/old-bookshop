require 'thor/group'
require 'erb'
require 'fileutils'
require 'yaml'

require 'bookshop/commands/yaml/book'

module Bookshop
  module Commands

    # Define build commands for bookshop command line
    class EpubBuild < Thor::Group
      include Thor::Actions
      
      app_path = APP_PATH
      BOOK_SOURCE = "book.html.erb"

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

      # Create the project from templates
      def create_base_project
        # Clean up any old builds
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/epub/*')
        
        puts "Creating epub base files"
        directory "templates", "#{app_path}/builds/epub/"
      end
      
      @output = :epub
      erb = import(BOOK_SOURCE)
      puts "Generating new html from erb"
      File.open('builds/epub/OEBPS/book.html', 'a') do |f|
        f << erb
      end
      
      def copy_over_assets
        # Copy over html assets
        FileUtils.cp_r('book/css/', 'builds/epub/OEBPS/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/epub/OEBPS/', :verbose => true)
      end
    end
  end
end
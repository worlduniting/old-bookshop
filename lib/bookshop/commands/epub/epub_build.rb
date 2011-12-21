require 'thor/group'
require 'erb'
require 'yaml'
require 'zip/zip'
require 'zip/zipfilesystem'

module Bookshop
  module Commands

    # Builds the EPUB version of the book
    class EpubBuild < Thor::Group
      include Thor::Actions
      
      # Define arguments and options
      argument :app_path,               :type => :string
      
      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end

      # Create the project from templates
      def create_base_project
        puts "creating base project"
        directory "templates", "#{app_path}"
      end
      
      
      def clean_up
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/epub/*')
      end
      
      def create_epub_structure
        directory "templates", "builds/epub"
      end
      
      def generate_toc
        make table of contents
      end
      
      def compile_erb_source
        @output = :epub

        erb = import('book.html.erb')

        # Generate the html from ERB
        puts "Generating new html from erb"
        File.open('builds/epub/OEBPS/book.html', 'a') do |f|
          f << erb
        end
      end
      
      def zip_epub
        
        zip the contents into book_#{Time.now.strftime('%m-%e-%y').epub}
      end
      
      def validate_epub
        cmd = %x[tools/epubcheck book_#{Time.now.strftime('%m-%e-%y').epub]
      end
  

# Builds the pdf from builds/html/book.html
puts "Building new pdf at builds/pdf/book.pdf from new html build"




generate html from ERB
create empty folders
  META-INF/
  OEBPS/
create file META-INF/container.xml
create file OEBPS/content.opf (use thor templates)
  pull book.yml data into file
create file OEBPS/toc.ncx
  pull book.yml data into file
create file mimetype with "application/epub+zip"
zip contents
validate book_(date).epub with Epubcheck 1.2
require 'thor/group'
require 'erb'
require 'yaml'


require 'bookshop/commands/yaml/book'

module Bookshop
  module Commands

    # Builds the EPUB version of the book
    class EpubBuild < Thor::Group
      include Thor::Actions
      
      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end
        

      
      def clean_up
        puts "Deleting any old builds"
        FileUtils.rm_r Dir.glob('builds/epub/*')
        FileUtils.rm_r Dir.glob('builds/html/*')
      end
      
      def compile_erb_source
        @output = :epub
        
        erb = import(BOOK_SOURCE)

        # Generate the html from ERB
        puts "Building new epub at builds/epub/book.epub"
        File.open('builds/epub/OEBPS/book.html', 'a') do |f|
          f << erb
        end
        FileUtils.cp_r('book/css/', 'builds/epub/OEBPS/', :verbose => true)
        FileUtils.cp_r('book/images/', 'builds/epub/OEBPS/', :verbose => true)
      end
      
      # Load the book.yml into the Book object
      @book = Book.new(YAML.load_file('config/book.yml'))
      @toc = Toc.new(TAML.load_file('config/table_of_contents.yml'))
      
      def create_epub_structure
        directory "templates/epub", "builds/epub"
      end
      
      def generate_content_opf_file
        template "templates/content.opf.tt" "builds/epub/OEBPS"
      end

      def generate_toc
        template "templates/toc.ncs.tt" "builds/epub/OEBPS"
      end
      
      def zip_epub
        # zip the contents into book.epub
      end
      
      def validate_epub
        # cmd = %x[tools/epubcheck book_#{Time.now.strftime('%m-%e-%y').epub]
      end
    end
  end
end
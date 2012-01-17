require 'thor/group'
require 'erb'
require 'yaml'

BOOK_SOURCE = 'book/book.html.erb'

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
      
      puts "Deleting any old builds"
      FileUtils.rm_r Dir.glob('builds/epub/*')
      FileUtils.rm_r Dir.glob('builds/html/*')

      
      @output = :epub

      erb = import(BOOK_SOURCE)

      # Generate the html from ERB
      puts "Building new html at builds/epub/OEBPS/book.html"
      File.open('builds/epub/OEBPS/book.html', 'a') do |f|
        f << erb
      end
      FileUtils.cp_r('book/css/', 'builds/epub/OEBPS/', :verbose => true)
      FileUtils.cp_r('book/images/', 'builds/epub/OEBPS/', :verbose => true)
   
      

    end
  end
end
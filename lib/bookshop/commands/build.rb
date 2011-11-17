require 'thor/group'

module Bookshop
  module Commands
    # Define build commands for bookshop command line
    class Build < Thor::Group
      include Thor::Actions
      
      ARGV << '--help' if ARGV.empty?

      SRC_FILE = 'book/book.html'
      PDF_OUTPUT_FILE = 'builds/pdf/book.pdf'

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
      when 'pdf'
        puts "Deleting any old builds"
        File.delete("builds/pdf/book.pdf") if File::exists?( "builds/pdf/book.pdf" )
        puts "File Deleted"
        puts "Building new pdf at builds/pdf/book.pdf"
        cmd = %x[wkhtmltopdf #{SRC_FILE} #{OUT_FILE}]
      
      when 'epub'
        puts "Deleting any old builds"
        File.delete("builds/epub/book.epub") if File::exists?( "builds/epub/book.epub" )
        puts "File Deleted"
        
        puts "Building new epub at builds/epub/book.epub"
        cmd = %x[cd book/ && zip -X0 "builds/epub/book.epub" mimetype && zip -rDX9 "builds/epub/book.epub" * -x "*.DS_Store" -x mimetype]
        
        puts "Validating epub"
        cmd = %x[java -jar tools/epubcheck-1.2.jar builds/epub/book.epub]

      
      # fix this
      when 'mobi'
        puts "Deleting any old builds"
        File.delete("builds/mobi/book.*") if File::exists?( "builds/mobi/book.*" )
        puts "File Deleted"
        
        puts "Building new epub at builds/mobi/book.epub"
        cmd = %x[tools/xsl/epub/bin/dbtoepub -v book/book.xml -o builds/mobi/book.epub]
        
        puts "Validating epub"
        cmd = %x[java -jar tools/java/epubcheck-1.2.jar builds/mobi/book.epub]
        
        puts "Generating mobi file at builds/mobi/book.mobi"
        cmd = %x[rm ../book.* && epubmake && epubcheck && /Applications/Kindle/KindleGen/kindlegen ../book.epub]
        
        puts "Cleaning up..."
        File.delete("builds/mobi/book.epub") if File::exists?( "builds/mobi/book.epub" )
        
      # to be fixed
      
      # when 'html'
        # puts "Deleting your old html build"
        # File.delete("builds/html/book.html") if File::exists?( "builds/html/book.html" )
        # puts "File Deleted"
        
        # puts "Building new html at builds/html/book.html"
        # cmd = %x[java -jar tools/java/xalan.jar -in book/book.xml -xsl stylesheets/html-stylesheet.xsl -out builds/html/book.html]
        
      when 'all'        
        puts "Building pdf..."
        puts "Deleting any old builds"
        File.delete("builds/pdf/book.pdf") if File::exists?( "builds/pdf/book.pdf" )
        puts "File Deleted"
        puts "Building new pdf at builds/pdf/book.pdf"
        cmd = %x[java -jar tools/java/fop.jar -xml book/book.xml -xsl stylesheets/fo-stylesheet.xsl builds/pdf/book.pdf]

        puts "Building epub..."
        puts "Deleting any old builds"
        File.delete("builds/epub/book.epub") if File::exists?( "builds/epub/book.epub" )
        puts "File Deleted"
        puts "Building new pdf at builds/epub/book.epub"
        cmd = %x[tools/xsl/epub/bin/dbtoepub -v book/book.xml -o builds/epub/book.epub]

        puts "Building mobi..."
        puts "Deleting any old builds"
        File.delete("builds/mobi/book.*") if File::exists?( "builds/mobi/book.*" )
        puts "File Deleted"
        puts "Building new epub at builds/mobi/book.epub"
        cmd = %x[tools/xsl/epub/bin/dbtoepub -v book/book.xml -o builds/mobi/book.epub]
        puts "Validating epub"
        cmd = %x[java -jar tools/java/epubcheck-1.2.jar builds/mobi/book.epub]
        puts "Generating mobi file at builds/mobi/book.mobi"
        cmd = %x[tools/kindle/kindlegen builds/mobi/book.epub]
        puts "Cleaning up..."
        File.delete("builds/mobi/book.epub") if File::exists?( "builds/mobi/book.epub" )
        
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

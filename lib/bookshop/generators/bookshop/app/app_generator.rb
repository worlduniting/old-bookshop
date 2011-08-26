require 'rubygems'
require 'thor/group'

module Bookshop
  module Generators

    class AppGenerator < Thor::Group
      include Thor::Actions

      # Define arguments and options
      argument :app_path,                   :type => :string
                                        

      class_option :dtd,                :type => :string, :aliases => "-dtd",
                                        :desc => "DTD version [ 4.5, 5.0 ]", :default => "4.5"

      class_option :xsl,                :type => :string, :aliases => "-xsl",
                                        :desc => "DocBook-XSL version [ 1.75.2, 1.76.1 ]", :default => "1.76.1"
      
      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end

      # Create the project from templates
      def create_base_project
        puts "creating base project"
        directory "templates", "#{app_path}"
      end

      # Adds the dtd specified by user
      def add_dtd
        puts "creating dtd"
        dtd = "#{options[:dtd]}"
        directory "tools/dtd/#{options[:dtd]}", "#{app_path}/tools/dtd"
      end

      # Adds the XSL/version specified by user
      def add_xsl
        directory "tools/xsl/#{options[:xsl]}", "#{app_path}/tools/xsl"
      end

      # Change the permissions so dbtoepub is executable 
      def chmod_dbtoepub
        chmod "#{app_path}/tools/xsl/epub/bin/dbtoepub", 0755
      end
      
      # Adds the Java jars and dependencies
      def add_java
        directory "tools/java/", "#{app_path}/tools/java"
      end
      
    protected

      def self.banner
        "bookshop new #{self.arguments.map(&:usage).join(' ')} [options]"
      end

    end
  end
end

require 'rubygems'
require 'thor/group'

module Bookshop
  module Generators

    class AppGenerator < Thor::Group
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

      # Adds the Java jars and dependencies
      def add_tools
        directory "tools/", "#{app_path}/tools/"
      end

      # Change the permissions so dbtoepub is executable 
      def chmod_tools
        chmod "#{app_path}/tools/epubcheck-1.2.jar", 0755
        chmod "#{app_path}/tools/kindlegen", 0755
      end

    protected

      def self.banner
        "bookshop new #{self.arguments.map(&:usage).join(' ')} [options]"
      end

    end
  end
end

require 'rubygems'
require 'thor/group'

module Bookshop
  module Generators
    # Thor based generator for creating new projects based upon a template project which
    # is copied into the name_of_book project-folder when 'build new name_of_book' is issued
    class AppGenerator < Thor::Group
      include Thor::Actions

      # Define arguments and options
      argument :app_path, :optional=> true, :type => :string
      
      # Define source root of application
      def self.source_root
        File.dirname(__FILE__)
      end

      
      # Create the project from templates
      def create_base_project
        raise GeneratorArgumentsError if app_path.nil?
        puts "creating base project"
        directory "templates", "#{app_path}"
      end

    protected

      def self.banner
        raise ArgumentsError
      end

    end
  end
end

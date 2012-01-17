require 'thor/group'
require 'erb'
require 'fileutils'
require 'yaml'

require 'bookshop/commands/yaml/book'

require 'bookshop/commands/epub/'

module Bookshop
  module Commands

    # Define build commands for bookshop command line
    class EpubBuild < Thor::Group
      puts "EpubBuild Worked"
      #include Thor::Actions
      
      # Define arguments and options
      #argument :app_path
      
      # Define source root of application
      #def self.source_root
      #  File.dirname(__FILE__)
      #end

      # Create the project from templates
      #def create_base_project
      #  puts "creating base project"
      #  directory "templates", "#{app_path}"
      #end
    end
  end
end
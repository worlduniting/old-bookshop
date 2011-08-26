require 'pathname'

module Bookshop
  # Checks to see if we are in a bookshop application
  module ScriptBookshopLoader
    RUBY = File.join(*RbConfig::CONFIG.values_at("bindir", "ruby_install_name")) + RbConfig::CONFIG["EXEEXT"]
    SCRIPT_BOOKSHOP = File.join('script', 'bookshop')

    def self.exec_script_bookshop!
      cwd = Dir.pwd
      return unless in_bookshop_application? || in_bookshop_application_subdirectory?
      exec RUBY, SCRIPT_BOOKSHOP, *ARGV if in_bookshop_application?
      Dir.chdir("..") do
        # Recurse in a chdir block: if the search fails we want to be sure
        # the application is generated in the original working directory.
        exec_script_bookshop! unless cwd == Dir.pwd
      end
    rescue SystemCallError
      # could not chdir, no problem just return
    end

    def self.in_bookshop_application?
      File.exists?(SCRIPT_BOOKSHOP)
    end

    def self.in_bookshop_application_subdirectory?(path = Pathname.new(Dir.pwd))
      File.exists?(File.join(path, SCRIPT_BOOKSHOP)) || !path.root? && in_bookshop_application_subdirectory?(path.parent)
    end
  end
end
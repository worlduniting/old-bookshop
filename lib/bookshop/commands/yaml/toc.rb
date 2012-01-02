# Take a YAML data structure and express it in a 'class.attribute.attribute' convention so
#   it can be used in the source files to call data from the toc.yml file
#
# # toc.yml
# foo:
#   bar: foobar
#
# is referenced in the source files as <%= toc.foo.bar %> and yields in build 'foobar'
module Bookshop
  module Commands
    class Toc

      def initialize(data={})
        @data = {}
        update!(data)
      end

      def update!(data)
        data.each do |key, value|
          self[key] = value
        end
      end

      def [](key)
        @data[key.to_sym]
      end

      def []=(key, value)
        if value.class == Hash
          @data[key.to_sym] = Book.new(value)
        else
          @data[key.to_sym] = value
        end
      end

      def method_missing(sym, *args)
        if sym.to_s =~ /(.+)=$/
          self[$1] = args.first
        else
          self[sym]
        end
      end

    end
  end
end
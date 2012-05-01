
module Bookshop

  class Error< StandardError
    
  end

  class ArgumentsError< Error
  
    def to_s
       "  bookshop new BOOK_NAME [options]"
    end

  end

  class GeneratorArgumentsError < ArgumentsError
    def to_s
      "Usage:\n" + super
    end
  end

end

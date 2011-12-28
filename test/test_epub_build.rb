require 'test/unit'
require 'mocha'


class EpubBuildTest < Test::Unit::TestCase
  def build_html_from_erb_source
    assert true
  end
  
  def create_epub_dir_structure
    # copy file from templates to destination
    assert true # mimetype is present
  end
  
  def create_content_opf_file
    # extract book.yml data into content
    # insert all files into <metadata> section
    # insert all files into <manifest> section
    # insert all files into <spine> section
    # insert all files into <guide> section
    assert true
  end
  
  def create_toc_ncx_file
    # create new ncx file
    # insert metadata items
    # insert title and authors
    # create navMap based upon toc.yml
    assert true
  end
  
  def zip_epub_contents
    # zip files into epub standard format
    assert true # book.epub exists
  end
  
  def validate_epub
    # run epubcheck against book.epub
    assert true # passes without errors
  end
end
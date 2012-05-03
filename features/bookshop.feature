Feature: We can create a new book project and build books
	We need to be able to create a new book project so we can manage
	the book's content/layout in one place and then convert it into many
	different types of print and/or (e)Books.
		
	Scenario: Create a new book project
		When I successfully run `bookshop new test_book`
		Then the output should contain "config/book.yml"
		When I cd to "test_book"
		Then the following files should exist:
		| book/book.html.erb |
		| book/assets/images/canvas.jpg |
		| book/frontmatter/toc.html.erb |
		| config/book.yml |
		| README.rdoc |
		| script/bookshop |
		| script/epubcheck/epubcheck.jar |
		| script/epubcheck/lib/jing.jar |
		| script/epubcheck/lib/saxon.jar |
		And the following directories should exist:
		| builds/epub |
		| builds/html |
		| builds/pdf |
		| builds/mobi |
     
  @no-clobber
  Scenario: Build a new pdf book
  	Given a file named "test_book/script/bookshop" should exist		
  	When I cd to "test_book"
  	And I run `bookshop build pdf`
  	Then the output should contain "Building new pdf"
  	And the output should contain "prince: Loading document"
  	And the output should not contain "error"
  	And a file named "builds/pdf/book.pdf" should exist
  	And the file "builds/pdf/book.html" should match /stylesheet.pdf.css/

  @no-clobber
  Scenario: Build a new html book
  	Given a file named "test_book/script/bookshop" should exist
  	When I cd to "test_book"
  	And I run `bookshop build html`
  	Then the output should contain "Generating new html from erb"
  	Then the following files should exist:
  	| builds/html/book.html |
  	| builds/html/assets/css/stylesheet.html.css |
  	| builds/html/assets/images/canvas.jpg |
  	And the file "builds/html/book.html" should match /stylesheet.html.css/

  @no-clobber
  Scenario: Build a new epub book
  	Given a file named "test_book/script/bookshop" should exist
  	When I cd to "test_book"
  	And I run `bookshop build epub`
		Then the output should contain "Deleting any old builds"
		Then the output should contain "Generating new html from erb"
		Then the output should contain "Generating new content.opf from erb"
		Then the output should contain "Generating new toc.ncx from erb"
		Then the output should contain "Zipping up into epub"
  	Then the following files should exist:
  	| builds/epub/mimetype |
  	| builds/epub/META-INF/container.xml |
  	| builds/epub/OEBPS/assets/css/page-template.xpgt |
  	| builds/epub/OEBPS/assets/images/canvas.jpg |
  	| builds/epub/OEBPS/assets/css/stylesheet.epub.css |
  	| builds/epub/OEBPS/toc.ncx |
  	| builds/epub/book.epub |
		And the file "builds/epub/OEBPS/book.html" should match /stylesheet.epub.css/
		And the file "builds/epub/OEBPS/content.opf" should match /stylesheet.epub.css/
  	
  @no-clobber
  Scenario: Build a new mobi book
  	Given a file named "test_book/script/bookshop" should exist
  	Given a file named "test_book/script/kindlegen/kindlegen_mac" should exist
  	When I cd to "test_book"
  	And I run `bookshop build mobi`
  	Then the output should contain "Deleting any old builds"
  	Then the output should contain "Generating new html from erb"
  	Then the output should contain "Generating new content.opf from erb"
  	Then the output should contain "Generating new toc.ncx from erb"
  	Then the output should contain "Zipping up into epub"
  	Then the output should contain "Epubcheck Version"
  	And the output should not contain "ERROR"
  	Then the output should contain "Amazon.com"
  	Then the following files should exist:
  	| builds/mobi/mimetype |
  	| builds/mobi/META-INF/container.xml |
  	| builds/mobi/OEBPS/assets/css/page-template.xpgt |
  	| builds/mobi/OEBPS/assets/images/canvas.jpg |
  	| builds/mobi/OEBPS/assets/css/stylesheet.mobi.css |
  	| builds/mobi/OEBPS/toc.ncx |
  	| builds/mobi/book.epub |
  	| builds/mobi/book.mobi |
  	And the file "builds/mobi/OEBPS/book.html" should match /stylesheet.mobi.css/
  	And the file "builds/mobi/OEBPS/content.opf" should match /stylesheet.mobi.css/
		

  @usage-error
    Scenario: Run bookshop without arguments
      When I run `bookshop`
      Then the output should contain "Usage:\n  bookshop new BOOK_NAME [options]"
  @usage-error
   Scenario: Run bookshop new without path
     When I run `bookshop new`
     Then the output should contain "Usage:\n  bookshop new BOOK_NAME [options]"

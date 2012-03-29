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
		And the following directories should exist:
		| builds/epub |
		| builds/html |
		| builds/pdf |
		| builds/mobi |
	
		
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
		
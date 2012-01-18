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
		| book/images/canvas.jpg |
		| book/toc.html.erb |
		| config/book.yml |
		| config/toc.yml |
		| README.rdoc |
		| script/bookshop |
		And the following directories should exist:
		| builds/epub |
		| builds/html |
		| builds/pdf |
		| builds/mobi |
	
	#@no-clobber
	#Scenario: Build a new pdf book
	#	Given a file named "test_book/script/bookshop" should exist		
	#	When I cd to "test_book"
	#	And I run `bookshop build pdf`
	#	And a file named "builds/pdf/book.pdf" should exist
	
	#@no-clobber
	#Scenario: Build a new html book
	#	Given a file named "test_book/script/bookshop" should exist
	#	When I cd to "test_book"
	#	And I run `bookshop build html`
	#	Then the output should contain "Generating new html from erb"
	#	And a file named "builds/html/book.html" should exist
	#	And the file "builds/html/book.html" should match /Title:/
		
	@no-clobber
	Scenario: Build a new epub book
		Given a file named "test_book/script/bookshop" should exist
		When I cd to "test_book"
		And I run `bookshop build epub`
		Then the following files should exist:
		| builds/epub/mimetype |
		| builds/epub/META-INF/container.xml |
		| builds/epub/OEBPS/css/page-template.xpgt |
		| builds/epub/OEBPS/css/stylesheet.css |
		| builds/epub/OEBPS/images/canvas.jpg |
		| builds/epub/OEBPS/css/stylesheet.css |
		And the file "builds/epub/OEBPS/book.html" should match /ePub Version/
		
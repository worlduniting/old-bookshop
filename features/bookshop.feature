Feature: We can create a new book project and build books
	We need to be able to create a new book project so we can manage
	the book's content/layout in one place and then convert it into many
	different types of print and/or (e)Books.
		
	Scenario: Create a new book project
		When I successfully run `bookshop new test_book`
		Then the output should contain "config/book.yml"
	
	@no-clobber
	Scenario: Build a new pdf book
		Given a file named "test_book/script/bookshop" should exist		
		When I cd to "test_book"
		And I run `bookshop build pdf`
		Then the output should contain "Loading pages"
		And a file named "builds/pdf/book.pdf" should exist

	# @no-clobber	ensures that the previous Scenario's generated book project files are
	# not deleted, so we can use them for the following scenarios
	@no-clobber
	Scenario: Build a new html book
		Given a file named "test_book/script/bookshop" should exist
		When I cd to "test_book"
		And I run `bookshop build html`
		Then the output should contain "Generating new html from erb"
		And a file named "builds/html/book.html" should exist
		And the file "builds/html/book.html" should match /Title:/
		
	#@no-clobber
	#Scenario: Build a new epub book
	#	Given a file named "test_book/script/bookshop" should exist
	#	When I cd to "test_book"
	#	And I run `bookshop build epub`
	#	Then the output should contain "Building new epub at builds/epub/book.epub"
	#	And a file named "builds/epub/book.epub" should exist
		
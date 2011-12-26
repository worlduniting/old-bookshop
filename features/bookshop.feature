Feature: We can create a new book project
	As a publisher I need to be able to create a new book project so we
	can manage the book's content/layout in one place and then convert it
	into many different types of print and (e)Books.
	
Scenario: Create a new book project
	Given the project folder "/tmp/test_book" does not exist
	When I successfully run 'bookshop new test_book'
	Then the stdout should contain "test_book"
	And a new folder "/tmp/test_book/README.rdoc" should exist
	And a new file "/tmp/test_book/config/book.yml" should exist 


# A bookshop user is likely to:

# create a new bookshop book project

# edit their book

# build a version of their book

# get help
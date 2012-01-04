## Bookshop 0.1.0 ##
### Documentation ###

* Added new website http://blueheadpublishing.github.com/bookshop/ using the gh-pages branch - which is then hosted on the git pages site

* Created the example book which serves as the test book for the cucumber tests, and as an example for users to see how to code their books.


## Bookshop 0.1.0 ##
### Documentation ###
* Added new website using the gh-pages branch - which is then hosted on the git pages site

* Created the example book which serves as the test book for the cucumber tests, and
			as an example for users to see how to code their books.
			
## Bookshop 0.0.19 ##
### Testing ###
* This release incorporates a new testing suite.
* I've added Aruba and Cucumber to create acceptance tests for the basic features of bookshop. This does not currently include any unit testing. I will be adding unit tests in a future release. Hopefully these basic acceptance tests will provide some essence of stability considering my recent cowboy coding. -)

## Bookshop 0.0.18 ##
### Features ###
* Added @output variable for use in ERB source files so conditionals can be used to define custom layouts based upon the type of output being built (e.g. html, pdf, etc)
		
* Abstracted the book-to-yaml class into it's own class under */commands/yaml/book.rb
		
### Documentation
* Edited the example book to demonstrate use of "output" conditionals in ERB source files.
* Added documentation in README's to show use of "output" conditionals in ERB source

## Bookshop 0.0.17 ##
### Features ###
* Added config/book.yml, providing a data structure for elements accessible within the book/ source files.
			
* Added 'current date' to the end of the generated filename of builds.
			
### Clean-up ###
* Removed Template Generator for now, this has become part of the 0.2.0 milestone

## Bookshop 0.0.16 ##
### Features ###
* Added importing <%= import(your_source_file.html.erb) %> functionality for ERB source files, providing subtemplating, allowing for cleaner code layouts.
	
### Documentation ###
* Edited the example book which is generated with 'bookshop new'. The new layout demonstrates how to utilize the <%= import(your_source_file.html.erb) %> for including sub-files.
			
* Removed 'Tools' subfolder including Kindlegen and Epubcheck - I will include them in a future release. But removed for now to save bandwidth and reduce gem size.
		
* Made 'book/' the assumed directory for source in 'bookshop build' command and removed 'book/' prefix in all of the layout imports

## Bookshop 0.0.15 ##
### Features ###
* Added ERB functionality to the book source

## Bookshop 0.0.14 ##
* Moved repository to blueheadpublishing and modified gem source to update all links
			
### Features ###
* Added CHANGELOG into project template to provide users with a best-practices in documenting version changes

## Bookshop 0.0.13 ##
### Bug fixes ###
* Fixed build pdf command so it doesn't try to build epub

## Bookshop 0.0.12 ##
### Doc fixes ###
* Added new post-install message to alert users to install wkhtmltopdf
		
* Removed old POST_INSTALL file

## Bookshop 0.0.11 ##
### Complete rewrite ###
* Switched from docbook toolchain to html/css/javascript toolchain
		
* Removed all XML/XSLT/FOP dependencies since no longer using docbook
		
* Added wkhtmltopdf as the html-to-pdf processor
		
* Added Boom(.css) microformat to replace structural markup previously available via docbook
		
* Moved copyright to BlueHead Inc

## Bookshop 0.0.4 ##
###	Core Changes ###
*	Added new mobi build
		
*	Branding around World Uniting Press
		
* Added epubcheck for epub validations, v1.2
		
* Added kindlegen for generating mobi


## Bookshop 0.0.3 ##
### Core Changes ###
*	Added Java toolsets, including all necessary .jars for working with Docbook and bookshop

*	Updated documentation to include information on how to setup java tools and Classpaths on various systems
		
*	Added MIT-LICENSE
		
*	Application Generator now has dynamically generated dates and content
		
*	Added epub build command
		
*	Added pdf build command
		
*	Significant rework of Command Line Interface and 'help' dialogues
		
* Bookshop Bug Fixes
		(none as this was a substantial rework)
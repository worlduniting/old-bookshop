# config/initializers/pdfkit.rb
PDFKit.configure do |config|
  # config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  # config.default_options = {
  ## Global WKHTMLTOPDF options
  #   :print_media_type => true

  #   :title = 'Book Title'               # The title of the generated pdf file
  #   :no_collate => true                 # <yes/no> Do not collate when printing multiple copies (default no)
  #   :cookie_jar_path => '/path/to/jar'  # Read and write cookies from and to the supplied cookie jar file
  #   :copies = 1                         # <integer> Number of copies to print into the pdf file (default 1)
  #   :dpi = 300                          # Change the dpi explicitly (this has no effect on X11 based systems)
  #   :grayscale => true                  # <yes/no> PDF will be generated in grayscale (default no)
  #   :image_dpi = 600                    # <integer> When embedding images scale them down to this dpi (default 600)
  #   :image_quality = 94                 # <integer> When jpeg compressing images use this quality (default 94)
  #   :low_quality => true                # <yes/no> Generates lower quality pdf/ps. Useful to shrink the result document space (default no)
  #   :margin_bottom = '22mm'             # <real unit> Set the page bottom margin (default 10mm)
  #   :margin_left = '22mm'               # <real unit> Set the page left margin (default 10mm)
  #   :margin_right = '22mm'              # <real unit> Set the page right margin (default 10mm)
  #   :margin_top = '22mm'                # <real unit> Set the page top margin (default 10mm)
  #   :orientation = 'Landscape'          # Set orientation to Landscape or Portrait (default Portrait)
  #   :output_format = 'pdf'              # Specify an output format to use pdf or ps (default pdf)
  #   :page_size = 'Letter'               # Set paper size to: A4, Letter, (Google "Paper Size Chart" for others) (default A4)
  #   :page_width = '8.5in'               # <real unit> Page width (overrides page-size)
  #   :page_height = '11in'               # <real unit> Page height (overrides page-size)
  #   :no_pdf_compression => true         # <yes/no> Do not use lossless compression on pdf objects (default no)

  ## PDF Outline Settings

  #   :no_outline:                    # <yes/no> Do not put an outline into the pdf (default no)
  #   :outline_depth:                 # <integer> Set the depth of the outline (default 4)

  # Page Options
  #   :default_header:                # Add a default header, with the name of the
                                 #     page to the left, and the page number to
                                 #      the right, this is short for:
                                 #      --header-left='[webpage]'
                                 #      --header-right='[page]/[toPage]' --top 2cm
                                 #      --header-line
  #   :disable_external_links:        # Do not make links to remote web pages
  # }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.

end
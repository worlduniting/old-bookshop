# config/initializers/pdfkit.rb
PDFKit.configure do |config|
  # config.wkhtmltopdf = '/path/to/wkhtmltopdf'
  # config.default_options = {
      :page_size => 'Legal',
      :orientation => 'Portrait'
  #   :print_media_type => true
  # }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
end
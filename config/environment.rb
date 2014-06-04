# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Supertravel::Application.initialize!

# Files .PDF
Mime::Type.register 'application/pdf', :pdf
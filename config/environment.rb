# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Delfina::Application.initialize!

Time::DATE_FORMATS[:proper] = "%m-%d-%Y"

# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
#TODO change module name, using global find!
run Mbraids::Application

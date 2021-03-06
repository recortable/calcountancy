# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "newrelic_rpm"
#  config.gem "acts-as-taggable-on", :version => '2.0.4'
  config.gem 'inherited_resources', :source => 'http://gemcutter.org', :version => '1.0.3'
  config.gem 'formtastic'
  config.gem 'searchlogic'
  config.gem 'authlogic'
  config.gem 'cancan'

  config.time_zone = 'UTC'
  config.load_paths << "#{RAILS_ROOT}/lib"

  if RAILS_ENV == "development" && false
    puts "Setup request logger."
    config.middleware.use "RequestLogger"
  end

  config.i18n.default_locale = :es
end
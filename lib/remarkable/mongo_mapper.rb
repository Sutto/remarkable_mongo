# Load Remarkable
unless Object.const_defined?('Remarkable')
  begin
    require 'remarkable/core'
  rescue LoadError
    require 'rubygems'
    gem 'remarkable'
    require 'remarkable/core'
  end
end
 
# Add locale
dir = File.dirname(__FILE__)
Remarkable.add_locale File.join(dir, '..', '..', 'locales', 'en.yml')

require File.join(dir, 'mongo_mapper', 'base')
require File.join(dir, 'mongo_mapper', 'describe')
# require File.join(dir, 'remarkable_mongomapper', 'human_names')

# Add matchers
Dir[File.join(dir, 'mongo_mapper', 'matchers', '*.rb')].each do |file|
  require file
end

# Include Remarkable MongoMapper matcher in appropriate ExampleGroup
if defined?(RSpec::Rails)
  Remarkable.include_matchers!(Remarkable::MongoMapper, RSpec::Rails::ModelExampleGroup)
else
  Remarkable.include_matchers!(Remarkable::MongoMapper, RSpec::Core::ExampleGroup)
end

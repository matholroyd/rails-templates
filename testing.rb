generate :rspec

gem 'faker'
plugin 'machinist', :git => 'git://github.com/notahat/machinist.git'

file 'spec/blueprints.rb', <<-END
require 'faker'

# TODO
# Add blueprints
END

file 'spec/spec_helper.rb', <<-END
ENV['RAILS_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require File.expand_path(File.dirname(__FILE__) + '/blueprints')
require 'spec/autorun'
require 'spec/rails'
require 'authlogic/testing/test_unit_helpers'

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  config.before(:each) do
    Sham.reset 
    Authlogic::Session::Base.controller = nil
  end
end

def content_for(name)
  response.template.instance_variable_get("@content_for_#{name}")
end

END
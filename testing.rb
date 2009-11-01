generate :rspec

gem 'faker'
plugin 'machinist', :git => 'git://github.com/notahat/machinist.git'

file 'spec/blueprints.rb', <<-END
require 'faker'

# Example
# 
# Sham.name     { Faker::Name.name }
# Sham.email    { Faker::Internet.email }
# Sham.title    { Faker::Lorem.sentence }
# Sham.body     { Faker::Lorem.paragraph }
# Sham.keyword  { Faker::Lorem.words(1).first }
# Sham.country  { Faker::Address.uk_country }
# Sham.company  { Faker::Company.name }
# Sham.text     { Faker::Lorem.sentence }
# Sham.body     { Faker::Lorem.paragraph }
# Sham.subject  { Faker::Lorem.sentence }
# 
# User.blueprint do 
#   name 
#   email 
#   salt { 'salt' }
#   crypted_password { User.password_digest('secret', 'salt') }
#   state { 'active' }
#   default_country_or_region { @country }
#   created_at { 5.days.ago }
#   activated_at { 5.days.ago }
#   remember_token { '77de68daecd823babbb58edb1c8e14d7106e83bb' }
#   remember_token_expires_at { 1.day.from_now }
# end
# 
# JobApplication.blueprint do
#   user
#   title
#   company_name { Sham.company }
#   country_or_region { @country }
#   remuneration_offered { '50' }
#   remuneration_time_unit_id { TimeUnit::Hourly.id }
# end

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
  response.template.instance_variable_get("@content_for_\#{name}")
end
END
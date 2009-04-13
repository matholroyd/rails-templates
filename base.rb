
git :init

generate :rspec

run "echo TODO > README"

plugin 'make_resourceful', :source => 'git://github.com/hcatlin/make_resourceful'
plugin 'machinist', :source => 'git://github.com/notahat/machinist.git'

gem 'authlogic'
gem 'haml'
gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :source => 'http://gems.github.com'
# gem 'matholroyd-dbc'
# gem 'matholroyd-rails-standard-extensions'

git :rm => 'public/index.html' 

file '.gitignore', <<-END
config/database.yml
log/*.log
tmp/*
tmp/**/*
db/*.sqlite3
END

git :add => ".", :commit => "-m 'initial commit'"
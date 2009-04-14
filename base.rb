run "echo TODO > README"

plugin 'rails-standard-extensions', :git => 'git://github.com/matholroyd/rails-standard-extensions.git'
plugin 'make_resourceful', :git => 'git://github.com/hcatlin/make_resourceful.git'

gem 'haml'
gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :source => 'http://gems.github.com'
gem 'matholroyd-dbc', :lib => 'dbc', :source => 'http://gems.github.com'

run 'haml --rails .'
run 'rm public/index.html'

file '.gitignore', <<-END
config/database.yml
log/*.log
tmp/*
tmp/**/*
db/*.sqlite3
END

git :init
git :add => ".", :commit => "-m 'initial commit'"

if yes?("Run migrations?")
  rake 'db:migrate db:test:clone'
end
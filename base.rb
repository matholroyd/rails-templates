git :init

generate :rspec

run "echo TODO > README"

# plugin 'make_resourceful', :git => 'git://github.com/hcatlin/make_resourceful.git'
# plugin 'machinist', :git => 'git://github.com/notahat/machinist.git'
# plugin 'dbc', :git => 'git://github.com/matholroyd/dbc.git'
# plugin 'rails-standard-extensions', :git => 'git://github.com/matholroyd/rails-standard-extensions.git'

gem 'haml'
gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :source => 'http://gems.github.com'

rake 'gems:install'

run 'haml --rails .'
run 'rm public/index.html'

file '.gitignore', <<-END
config/database.yml
log/*.log
tmp/*
tmp/**/*
db/*.sqlite3
END

git :add => ".", :commit => "-m 'initial commit'"

if yes?("Run migrations?")
  rake 'db:migrate db:test:clone'
end
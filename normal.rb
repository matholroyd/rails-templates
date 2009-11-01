git :init

load_template 'http://github.com/matholroyd/rails-templates/raw/master/authentication.rb'
load_template 'http://github.com/matholroyd/rails-templates/raw/master/testing.rb'
load_template 'http://github.com/matholroyd/rails-templates/raw/master/base.rb'

git :add => ".", :commit => "-m 'initial commit'"
run 'op'
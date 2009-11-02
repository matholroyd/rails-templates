run "echo TODO > README"

plugin 'make_resourceful', :git => 'git://github.com/hcatlin/make_resourceful.git'

gem 'haml'
gem 'justinfrench-formtastic', :lib => 'formtastic', :source => 'http://gems.github.com'
gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :source => 'http://gems.github.com'
gem 'tworgy-ruby'
gem 'tworgy-rails'
gem 'machinist'

run 'haml --rails .'
run 'rm public/index.html'
run 'rm -fr test'
run 'rm public/images/rails.png'

file '.gitignore', <<-END
config/database.yml
log/*.log
tmp/*
tmp/**/*
db/*.sqlite3
END


file 'app/views/layouts/application.html.haml', <<-END
!!!
%html
  %head
    %meta{'http-equiv' => "Content-Type", :content => "text/css; charset=utf-8"}
    %title= yield(:title) || APP_NAME
    = stylesheet_link_tag 'main'
    = javascript_include_tag 'jquery-1.2.6.min', 'jquery.validate.min', 'jquery.field.min', :defaults
    = yield(:head)
  %body
    #container
      #header
        = render :partial => 'shared/user_bar'
        %h1 PUT YOUR APP TITLE HERE
      .site
        #side
          = yield(:side)
        #main
          %h1= yield(:heading) || auto_heading
          %flash
            %notice= flash[:notice] unless flash[:notice].blank?
            %error= flash[:error] unless flash[:error].blank?
          = yield
    #footer

END




if yes?("Run migrations?")
  rake 'db:migrate db:test:clone'
end

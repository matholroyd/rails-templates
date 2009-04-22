run "echo TODO > README"

plugin 'rails-standard-extensions', :git => 'git://github.com/matholroyd/rails-standard-extensions.git'
plugin 'make_resourceful', :git => 'git://github.com/hcatlin/make_resourceful.git'
plugin 'air_budd_form', :git => 'git://github.com/airblade/air_budd_form_builder.git'

gem 'haml'
gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :source => 'http://gems.github.com'
gem 'matholroyd-dbc', :lib => 'dbc', :source => 'http://gems.github.com'

run 'haml --rails .'
run 'rm public/index.html'
run 'rm -fr test'

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
    = stylesheet_link_tag 'main', 'air_budd_form_builder'
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

file 'public/stylesheets/air_budd_form_builder.css', <<-END
/* BUTTONS */

.hidden_area_links ul, .hidden_area_links ul li {
	display:inline;
	margin:0px;
}

.hidden_area_links ul li {
	color:blue;
	text-decoration:underline;
	cursor:pointer;
}

.hidden { 
	display:none;
}

.buttons {
	margin: 20px 0px;
}

.buttons a, .buttons button{
    display:inline;
    float:none;
    margin:0 7px 0 0;
    background-color:#f5f5f5;
    border:1px solid #dedede;
    border-top:1px solid #eee;
    border-left:1px solid #eee;

    font-family:"Lucida Grande", Tahoma, Arial, Verdana, sans-serif;
    font-size:100%;
    line-height:130%;
    text-decoration:none;
    font-weight:bold;
    color:#565656;
    cursor:pointer;
    padding:5px 10px 6px 7px; /* Links */
}
.buttons button{
    width:auto;
    overflow:visible;
    padding:4px 10px 3px 7px; /* IE6 */
}
.buttons button[type]{
    padding:5px 10px 5px 7px; /* Firefox */
    line-height:17px; /* Safari */
}
*:first-child+html button[type]{
    padding:4px 10px 3px 7px; /* IE7 */
}
.buttons button img, .buttons a img{
    margin:0 3px -3px 0 !important;
    padding:0;
    border:none;
    width:16px;
    height:16px;
}

/* STANDARD */

button:hover, .buttons a:hover{
    background-color:#dff4ff;
    border:1px solid #c2e1ef;
    color:#336699;
}
.buttons a:active{
    background-color:#6299c5;
    border:1px solid #6299c5;
    color:#fff;
}

/* POSITIVE */

button.positive, .buttons a.positive{
    color:#529214;
}
.buttons a.positive:hover, button.positive:hover{
    background-color:#E6EFC2;
    border:1px solid #C6D880;
    color:#529214;
}
.buttons a.positive:active{
    background-color:#529214;
    border:1px solid #529214;
    color:#fff;
}

/* NEGATIVE */

.buttons a.negative, button.negative{
    color:#d12f19;
}
.buttons a.negative:hover, button.negative:hover{
    background:#fbe3e4;
    border:1px solid #fbc2c4;
    color:#d12f19;
}
.buttons a.negative:active{
    background-color:#d12f19;
    border:1px solid #d12f19;
    color:#fff;
}
END

git :init
git :add => ".", :commit => "-m 'initial commit'"

if yes?("Run migrations?")
  rake 'db:migrate db:test:clone'
end
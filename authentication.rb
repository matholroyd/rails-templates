gem 'authlogic'

file 'app/models/user.rb', <<-END
class User < ActiveRecord::Base
  acts_as_authentic
end
END

file 'app/models/user_session.rb', <<-END
class UserSession < Authlogic::Session::Base
end  
END

file 'config/routes.rb', <<-END
ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource :user_session, :except => [:edit, :show, :update]
end
END

file 'app/controllers/user_sessions_controller.rb', <<-END
class UserSessionsController < ApplicationController
  skip_before_filter :require_user, :except => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default user_path(current_user)
    else
      flash[:error] = "Login unsuccessful"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
END

file 'app/controllers/application_controller.rb', <<-END
class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password

  before_filter :require_user

  protected

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def store_location
    session[:return_to] = request.request_uri
  end
end
END

file 'app/views/shared/_user_bar.html.haml', <<-END
#user_bar.site
  - if current_user
    = link_to 'log out', logout_path
  - else
    = link_to 'log in', login_path
END

file 'app/views/user_sessions/new.html.haml', <<-END
- content_for(:heading, "Log in")

= error_messages_for(:user_session)

- airbudd_form_for @user_session, :url => user_session_path do |f|
  = f.text_field :email
  = f.password_field :password
  - f.buttons do |b|
    = f.save :label => 'Log in'

END

file 'db/migrate/001_create_users.rb', <<-END
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.string :single_access_token, :null => false # optional, see the tokens section below.
      t.string :perishable_token, :null => false # optional, see the tokens section below.
      t.integer :login_count, :null => false, :default => 0 # optional, this is a "magic" column, see the magic columns section below
      t.integer :failed_login_count, :null => false, :default => 0 # optional, this is a "magic" column, see the magic columns section below

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table :users
  end
end
END

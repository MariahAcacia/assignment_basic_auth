class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, except: [:new, :create, :home]


private

  def require_login
    unless signed_in_user?
      flash[:error] = "Please Login!"
      redirect_to login_path
    end
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user


  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?


  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end


  def sign_out
    @current_user = nil
    session.delete(:user_id)
  end


end

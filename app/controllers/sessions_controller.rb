class SessionsController < ApplicationController

  def home
  end


  def new
    @user = User.find_by_username(params[:username])
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:sucess] = "Logged In Successfully"
      redirect_to users_path
    else
      flash.now[:error] = "Incorrect Username/Password or combination"
      redirect_to login_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Logged Out Successfully"
    redirect_to root_url
  end


end
